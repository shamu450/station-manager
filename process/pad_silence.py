#!/usr/bin/env python3
"""Prepend and append real silence to a CBR MP3, at the frame level.

Why this exists
---------------
The station crossfades every track into the next. `crossfade = 2.0` in the
station's `backend_config`, which means Liquidsoap ramps the first 2.0
seconds of an incoming track up from zero volume (and the overlap window is
crossfade * 1.5 = 3.0 seconds - see AzuraCast's
`StationBackendConfiguration::getCrossfadeDuration()`).

That is correct for music, which starts with an intro. It is destructive for
a spoken clip that starts talking at t=0: the opening words play at near-zero
volume underneath the outgoing song. Measured 2026-08-22 across all nine
interstitials - every one of them started speaking within 0.10s, so every one
was losing its first couple of words. The station owner heard it on the
station ID and transcribed the opening as "<broken audio>".

The fade duration is station-wide in every branch of AzuraCast's crossfade
code (`azuracast.liq`, `live_aware_crossfade_impl` - it passes
`settings.azuracast.default_fade()` to `cross.smart`, `cross.simple` and the
plain `add` fallback alike). The per-file `fade_in`/`fade_out` values in a
media record's `extra_metadata` feed the *autocue* path only, not this one,
so they cannot be used to opt a single file out. Padding the audio itself is
the fix that works from where this role sits.

There is no ffmpeg, sox or lame on this box, so this works on raw MPEG
frames instead: an MPEG-1 Layer III frame whose body is all zero bytes has
`part2_3_length == 0` for every granule, carries no Huffman data, and decodes
to digital silence. Silent frames are built by cloning the source file's own
4-byte frame header, so the padding always matches the source's bitrate,
sample rate and channel mode by construction.

Usage
-----
    pad_silence.py <in.mp3> <out.mp3> [lead_seconds] [tail_seconds]

Defaults to 2.0s of each. Writes a clean CBR stream: the ID3v2 tag, the
Xing/Info header frame and any ID3v1 trailer are dropped, so the frame count
in the file is the truth and every tool that reads it agrees on duration. (A
retained Xing header would still claim the *old* frame count and AzuraCast
would log a duration ~4s shorter than the file really is.)

**This is not idempotent.** Padding an already-padded file adds another two
seconds to each end - it pads, it doesn't normalise. Every clip in rotation
was padded once on 2026-08-22; don't run a bulk pass over them again. If you
need to check whether a file already has its silence, count leading all-zero
frames: 77 of them is 2.01s, which is what the current pipeline produces.
"""

import sys

# MPEG-1 Layer III. Index 0 is "free", index 15 is invalid; both unusable.
BITRATES_KBPS = [None, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, None]
SAMPLE_RATES = [44100, 48000, 32000, None]
SAMPLES_PER_FRAME = 1152


def id3v2_size(data):
    """Byte length of a leading ID3v2 tag, or 0 if there isn't one."""
    if len(data) < 10 or data[:3] != b"ID3":
        return 0
    # Syncsafe integer: 7 bits per byte.
    size = (data[6] & 0x7F) << 21 | (data[7] & 0x7F) << 14 | (data[8] & 0x7F) << 7 | (data[9] & 0x7F)
    return 10 + size


def frame_length(header):
    """Byte length of the frame this 4-byte header describes, or None."""
    if len(header) < 4 or header[0] != 0xFF or (header[1] & 0xE0) != 0xE0:
        return None
    bitrate = BITRATES_KBPS[(header[2] >> 4) & 0x0F]
    sample_rate = SAMPLE_RATES[(header[2] >> 2) & 0x03]
    if bitrate is None or sample_rate is None:
        return None
    padding = (header[2] >> 1) & 0x01
    return (144 * bitrate * 1000) // sample_rate + padding


def parse_frames(data):
    """Split an MP3 byte string into (header, whole_frame_bytes) pairs."""
    pos = id3v2_size(data)
    frames = []
    while pos + 4 <= len(data):
        length = frame_length(data[pos:pos + 4])
        if length is None or pos + length > len(data):
            break  # ID3v1 trailer, junk, or a truncated final frame.
        frames.append((data[pos:pos + 4], data[pos:pos + length]))
        pos += length
    return frames


def is_xing_frame(frame):
    """The leading VBR-info frame carries no audio and must not be kept."""
    return b"Xing" in frame or b"Info" in frame


def silent_frame(header):
    """A frame with the given header and an all-zero body: digital silence."""
    length = frame_length(header)
    return bytes(header) + b"\x00" * (length - 4)


def pad(data, lead_seconds=2.0, tail_seconds=2.0):
    frames = parse_frames(data)
    if not frames:
        raise ValueError("no MPEG audio frames found - not a usable MP3")

    if is_xing_frame(frames[0][1]):
        frames = frames[1:]
        if not frames:
            raise ValueError("file contained only a Xing header frame")

    header = frames[0][0]
    sample_rate = SAMPLE_RATES[(header[2] >> 2) & 0x03]
    frame_seconds = SAMPLES_PER_FRAME / sample_rate

    lead = round(lead_seconds / frame_seconds)
    tail = round(tail_seconds / frame_seconds)
    silence = silent_frame(header)

    out = silence * lead + b"".join(f for _, f in frames) + silence * tail
    return out, {
        "audio_frames": len(frames),
        "lead_frames": lead,
        "tail_frames": tail,
        "frame_ms": frame_seconds * 1000,
        "in_seconds": len(frames) * frame_seconds,
        "out_seconds": (len(frames) + lead + tail) * frame_seconds,
    }


def main():
    if not 3 <= len(sys.argv) <= 5:
        print(__doc__.strip().split("Usage\n-----\n")[1], file=sys.stderr)
        return 2

    src, dest = sys.argv[1], sys.argv[2]
    lead = float(sys.argv[3]) if len(sys.argv) > 3 else 2.0
    tail = float(sys.argv[4]) if len(sys.argv) > 4 else 2.0

    with open(src, "rb") as handle:
        data = handle.read()

    out, info = pad(data, lead, tail)

    with open(dest, "wb") as handle:
        handle.write(out)

    print(
        "padded {in_seconds:.2f}s -> {out_seconds:.2f}s "
        "({lead_frames} lead + {audio_frames} audio + {tail_frames} tail frames "
        "@ {frame_ms:.2f}ms)".format(**info),
        file=sys.stderr,
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())

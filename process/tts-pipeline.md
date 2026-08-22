How to turn something you want to say into an actual clip in rotation.

**Before you write one:** read [`clip-scripts.md`](clip-scripts.md), which
holds the full text of everything already on air. **After you generate one:**
add it there. Six clips went to air before that file existed with no record
of their words anywhere; all six were eventually recovered, but only because
the station owner sat and transcribed them by ear across two sessions. Don't
spend his time that way again - write the script down when you generate it.

Rough sizing: **size at 9 characters of script per second of audio**, which
is the slow end of the measured range, then read the real duration off the
upload. 45 seconds is a good default; a clip a listener meets every hour
shouldn't run to a minute without a reason. Expect to overshoot on the first
take and re-cut - under `eleven_v3` that is normal, not a mistake.

## Usage

```
echo "Your script here." | ./generate_and_upload.sh <voice_id> <dest_path.mp3>
```

Text comes in on stdin, not as an argument - avoids shell-quoting problems
with apostrophes and quotes in spoken text. `voice_id` is the ElevenLabs
voice ID from `identity.md`. `dest_path` is where the file lands in the
station's media library (see below for how to pick it).

The script generates the audio via ElevenLabs, uploads it to AzuraCast, and
prints the resulting media object (including its media ID) on success.

## Every clip's script is saved automatically

`generate_and_upload.sh` writes the exact text it sent to ElevenLabs to
`clip-text/<same path as the media file>.txt` on every successful upload.
You do not have to do anything to make this happen and you should not skip
it by calling the API directly.

Why it exists: when a clip sounds wrong on air, the first question is always
whether the audio mis-rendered the script or the script was wrong. Without
the source text that is unanswerable, and it has already been unanswerable
once, on the `2Pac` clip. Now it is a diff.

Re-cutting a clip overwrites its text file. Git keeps the history, so
`git log -p clip-text/<path>.txt` is the full script history for that one
clip.

This does not replace `clip-scripts.md`. That file is the readable record a
human reads, with register notes and retired transcripts, and you still
write to it when you generate a clip. `clip-text/` is the machine-written
copy that is guaranteed to be byte-exact.

## Writing for pacing - real feedback, 2026-08-22

The station owner reported pacing trouble and stumbling on some clips.
Voice settings got a first tuning pass the same day (see
`generate_and_upload.sh`), but the script text you write matters just as
much as the API settings:

- **The two-second dead-air buffer is handled for you now - don't write it
  into the script.** The station owner asked for one on each end, and he was
  right about the need, but you can't get it from text: ElevenLabs trims
  leading and trailing silence, and no amount of ellipsis reliably buys two
  seconds. `generate_and_upload.sh` now pads the generated MP3 with real
  silence before uploading (`pad_silence.py`). Why it matters is in that
  file's docstring; the short version is that the station crossfades at 2.0
  seconds and was ramping the opening words of every clip up from zero.
- Write full sentences with real punctuation - periods, commas - not one
  long run-on line. The model uses punctuation as its main pacing cue.
- **You cannot predict a clip's duration from its script.** Corrected
  2026-08-22 (13th wake). The 12th wake had concluded from two takes that
  "a full stop costs about 1.5-2 seconds" and that sentence count drives
  length; twelve more takes killed that model. Measured across **15 takes**
  on one voice at one setting, delivery runs **8.86 to 12.09 char/s**, and
  the sentence-count fit built from the first two points under-predicted the
  very next clip by 25%.

  *Range widened 2026-08-22 (14th wake):* clip 10 came back at **12.09
  char/s**, above the 11.73 top end the 13th wake had measured over 14
  takes. Don't treat the observed range as a converged interval - it has
  widened at both the 13th and 14th wake. ~9 char/s stays the safe sizing
  figure precisely because the spread keeps turning out bigger than the
  last measurement said.

  The clean disproof: the Rascalz clip was re-cut from 641 characters to
  **567** and came back **2.3 seconds longer** (59.7s → 62.0s). Fewer
  characters, fewer sentences, more audio.

  So: size at ~9 char/s, generate, and read the actual duration out of
  `pad_silence.py`'s stderr line. If it overshot, cut words and go again.
  Two or three takes to land a length is the expected cost, and at
  half-rate billing it's affordable.
- **Trim by cutting words, not by merging sentences.** The 13th wake tried
  merging sentences first, on the strength of the dead 2.7s-per-full-stop
  model, and it bought back nothing reliable.
- **Spelled-out letters cost about 0.4s each** - far slower than prose.
  `C A S A N O V A` plus `F L Y` is eleven letters and roughly four and a
  half seconds. That's why the Caz clip is the slowest per character in the
  pool. Worth it when the letters *are* the line; expensive otherwise.
- An ellipsis (`...`) or a short standalone sentence works as a deliberate
  pause where you want one - test what actually sounds right rather than
  assuming.

- Spell stylized names phonetically, not as styled. `2Pac` got read with
  the "2" dropped and "Pac" mispronounced, 2026-08-22 - the model reads
  literal characters, it doesn't know a digit is standing in for a word.
  Write `Tupac`, not `2Pac`. Same applies to any other artist name that
  uses a digit or symbol in place of a word (`50 Cent` -> spell it
  `Fifty Cent` if it comes up).

Not a solved problem yet - the voice_settings tuning is a starting point,
not measured against this voice specifically. Listen back and adjust both
the settings and how you write the next few scripts.

## Model: `eleven_v3`, set by the station owner

He switched `generate_and_upload.sh` from `eleven_multilingual_v2` to
`eleven_v3` and moved `stability` 0.6 -> 0.1 and `style` 0.15 -> 0.25,
noting "better quality". First actually exercised 2026-08-22 (12th wake) -
**it works**; the request returns 200 with this key, this voice and a
stability of 0.1, which was worth confirming rather than assuming since
some ElevenLabs models constrain stability to discrete values.

Both of the first run's provisional findings were re-tested in the 13th
wake, when the whole pool was re-cut on v3:

- **v3 bills at exactly half rate - confirmed three times.** 639 characters
  → 319 charged (12th wake), 498 → 249 (13th), 461 → 231 (14th), and across
  the 13th's whole session 6,329 characters over 12 calls → **3,170 charged**
  (half is 3,164.5; the gap is rounding). The effective monthly budget is
  ~80,000 characters, not 40,000, and a re-take of a typical clip costs
  about 250. Re-cutting the entire nine-clip pool twice over would still
  fit in a month. **This is what makes the measure-then-re-cut loop above
  affordable** - treat re-takes as the correction mechanism, not waste.
- **v3 is materially slower than `eleven_multilingual_v2`, and the gap is
  not constant.** Two clips were re-cut from near-identical scripts, which
  makes them a controlled comparison:

  | clip | v2 | v3 | change |
  |---|---|---|---|
  | Maestro | 552 ch / 44.0s | 560 ch / 58.6s | **+33%** |
  | reggae lineage | 563 ch / 44.0s | 558 ch / 50.6s | **+15%** |

  So budget 15-35% more runtime for the same words, and re-check the
  length of anything ported from the old model. Left unchecked this
  quietly pushed three clips past 60 seconds.
- The pacing numbers in the section above are all v3 at stability 0.1 and
  don't carry back to the old model, which was both faster (11.98-12.80
  char/s) and much more consistent.

## Where uploads go - always a subfolder, never the top level

`dest_path` is a real path in the station's media library, not just a
filename. The library is organized into folders on purpose - don't upload
flat at the root even though the API will happily let you.

Put spoken clips under `interstitials/`, e.g.
`interstitials/back-announce-2026-08-22.mp3`. Use subfolders under that if a
category grows large enough to want one (e.g. `interstitials/intros/`,
`interstitials/trivia/`) rather than dumping everything in one flat folder
once there's enough of it to be hard to scan.

The one existing exception is `test/`, used for one-off pipeline tests, not
real on-air content. New real clips go under `interstitials/`, not `test/`.

## Putting a clip into rotation

Generating and uploading a file doesn't put it into rotation on its own -
that's a separate AzuraCast step. As of 2026-08-21 there's one interstitial
playlist, `interstitials-dj-loop` (station playlist id 32): `is_jingle:
true`, `type: once_per_x_songs` with a `play_per_songs` cadence (plays
every N songs, tune via `PUT /api/station/{id}/playlist/32` as more clips
exist - started at 20 since one clip repeating too often gets old fast),
enabled alongside `0-Everything`.

**Don't copy the `is_jingle: true` part to a music playlist.** The two
settings here are unrelated: `type: once_per_x_songs` + `play_per_songs`
is what produces the cadence, while `is_jingle` only hides song titles
from listeners' players. That's right for these clips (nobody wants
`trivia-clip-04.mp3` as the now-playing title) and wrong for songs - the
9th wake had to undo exactly that mistake on `reggae` and `r-and-b`. See
CLAUDE.md.

To add an uploaded file to it:

```
curl -sk -H "X-API-Key: $AZURACAST_API_KEY" -H "Content-Type: application/json" \
  -X PUT "$AZURACAST_BASE_URL/api/station/$AZURACAST_STATION_ID/file/<media_id>" \
  -d '{"playlists": [{"id": 32}]}'
```

`<media_id>` is the `id` field `generate_and_upload.sh` prints on success.
More interstitial playlists (by category - intros, trivia, back-announce)
can follow the same pattern once there's enough content to want separate
cadences per category rather than one shared pool.

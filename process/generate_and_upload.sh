#!/usr/bin/env bash
# Turns a script into a spoken clip and drops it into the AzuraCast media
# library. Text comes from stdin (avoids shell-quoting headaches with
# apostrophes and quotes in spoken text). Usage:
#
#   echo "Yo, that was..." | ./generate_and_upload.sh <voice_id> <dest_path.mp3>
#
# dest_path is relative to the station's media root, e.g.
# "interstitials/back-announce-001.mp3".
#
# Uploading to a path that already exists REPLACES that file in place -
# same media id, same unique_id, playlist membership intact, only the
# duration updated. Verified 2026-08-22. That's how to fix an existing clip
# without knocking it out of rotation.
#
# TLS note: AzuraCast is reached over its internal-only self-signed cert
# (10.10.30.104), so curl uses -k here. Fine on this trusted internal
# network; would not be fine crossing a public network.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Seconds of real silence padded onto each end of the generated clip. The
# station crossfades at 2.0s, so without this the first two seconds of every
# clip get ramped up from zero volume and the opening words are lost. Not
# cosmetic - it cost the station ID its first three words. See
# pad_silence.py for the full explanation.
PAD_LEAD="${PAD_LEAD:-2.0}"
PAD_TAIL="${PAD_TAIL:-2.0}"

VOICE_ID="${1:?usage: generate_and_upload.sh <voice_id> <dest_path.mp3> (text on stdin)}"
DEST_PATH="${2:?usage: generate_and_upload.sh <voice_id> <dest_path.mp3> (text on stdin)}"

ENV_FILE="$HOME/.config/station-manager/env"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing credentials file: $ENV_FILE" >&2
  exit 1
fi
# shellcheck source=/dev/null
source "$ENV_FILE"

: "${ELEVENLABS_API_KEY:?not set in $ENV_FILE}"
: "${AZURACAST_API_KEY:?not set in $ENV_FILE}"
: "${AZURACAST_BASE_URL:?not set in $ENV_FILE}"
: "${AZURACAST_STATION_ID:?not set in $ENV_FILE}"

TEXT="$(cat)"
if [[ -z "$TEXT" ]]; then
  echo "No text provided on stdin" >&2
  exit 1
fi

TMP_AUDIO="$(mktemp --suffix=.mp3)"
TMP_BODY="$(mktemp)"
TMP_TTS_PAYLOAD="$(mktemp)"
TMP_UPLOAD_PAYLOAD="$(mktemp)"
trap 'rm -f "$TMP_AUDIO" "$TMP_BODY" "$TMP_TTS_PAYLOAD" "$TMP_UPLOAD_PAYLOAD"' EXIT

echo "Generating speech via ElevenLabs (voice ${VOICE_ID})..." >&2
# voice_settings tuned 2026-08-22 for pacing/stumbling (previously unset,
# running on account defaults). Starting point, not measured against this
# voice yet - adjust by ear.
## tuned by human - changed to eleven_v3 for better quality, changed stability
### please reprocess old clips with the new v3 model for newer better quality on air clips
# ^ done 2026-08-22 (13th wake): all 9 clips in rotation are v3 now. Note v3
# runs 15-35% longer than multilingual_v2 for the same script and its length
# is not predictable from character count - see tts-pipeline.md before
# porting any old script over. It bills at exactly half rate (confirmed).
python3 -c '
import json, sys
json.dump({
    "text": sys.stdin.read(),
    "model_id": "eleven_v3",
    "output_format": "mp3_44100_128",
    "voice_settings": {
        "stability": 0.1,
        "similarity_boost": 0.8,
        "style": 0.25,
        "use_speaker_boost": True,
    },
}, sys.stdout)
' <<<"$TEXT" > "$TMP_TTS_PAYLOAD"

HTTP_STATUS="$(curl -s -o "$TMP_AUDIO" -w "%{http_code}" \
  -X POST "https://api.elevenlabs.io/v1/text-to-speech/${VOICE_ID}" \
  -H "xi-api-key: ${ELEVENLABS_API_KEY}" \
  -H "Content-Type: application/json" \
  --data-binary "@${TMP_TTS_PAYLOAD}")"

if [[ "$HTTP_STATUS" != "200" ]]; then
  echo "ElevenLabs request failed (HTTP ${HTTP_STATUS}):" >&2
  cat "$TMP_AUDIO" >&2
  exit 1
fi

SIZE="$(stat -c%s "$TMP_AUDIO")"
echo "Got ${SIZE} bytes of audio." >&2

# Pad both ends with real silence so the station's 2.0s crossfade has
# something to chew on other than the first and last words.
TMP_PADDED="$(mktemp --suffix=.mp3)"
trap 'rm -f "$TMP_AUDIO" "$TMP_BODY" "$TMP_TTS_PAYLOAD" "$TMP_UPLOAD_PAYLOAD" "$TMP_PADDED"' EXIT
python3 "$SCRIPT_DIR/pad_silence.py" "$TMP_AUDIO" "$TMP_PADDED" "$PAD_LEAD" "$PAD_TAIL"

echo "Uploading to AzuraCast (station ${AZURACAST_STATION_ID}) at ${DEST_PATH}..." >&2
python3 -c '
import base64, json, sys
path, audio_path, out_path = sys.argv[1], sys.argv[2], sys.argv[3]
with open(audio_path, "rb") as f:
    data = base64.b64encode(f.read()).decode("ascii")
with open(out_path, "w") as f:
    json.dump({"path": path, "file": data}, f)
' "$DEST_PATH" "$TMP_PADDED" "$TMP_UPLOAD_PAYLOAD"

HTTP_STATUS="$(curl -sk -o "$TMP_BODY" -w "%{http_code}" \
  -X POST "${AZURACAST_BASE_URL}/api/station/${AZURACAST_STATION_ID}/files" \
  -H "X-API-Key: ${AZURACAST_API_KEY}" \
  -H "Content-Type: application/json" \
  --data-binary "@${TMP_UPLOAD_PAYLOAD}")"

if [[ "$HTTP_STATUS" != "200" ]]; then
  echo "AzuraCast upload failed (HTTP ${HTTP_STATUS}):" >&2
  cat "$TMP_BODY" >&2
  exit 1
fi

# One text file per clip, mirroring the media path under clip-text/, so the
# exact script that produced a given piece of audio can always be recovered
# and compared against what the clip actually says. Written automatically on
# every successful upload rather than left to a session to remember: six
# clips went to air with no surviving script precisely because it was a
# thing to remember. Re-cutting a clip overwrites its text file and git
# keeps the history, so `git log -p clip-text/<path>.txt` is that clip's
# full script history. process/clip-scripts.md stays the readable master
# record with its register notes; this is the machine-written one.
#
# DEST_PATH is used to build a local path here, so it has to be a plain
# relative path.
if [[ "$DEST_PATH" == /* || "$DEST_PATH" == *..* ]]; then
  echo "dest_path must be relative and must not contain '..': $DEST_PATH" >&2
  exit 1
fi

REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CLIP_TEXT_FILE="${REPO_ROOT}/clip-text/${DEST_PATH%.*}.txt"
mkdir -p "$(dirname "$CLIP_TEXT_FILE")"
printf '%s\n' "$TEXT" > "$CLIP_TEXT_FILE"
echo "Script text saved to ${CLIP_TEXT_FILE}" >&2

echo "Uploaded successfully." >&2
cat "$TMP_BODY"

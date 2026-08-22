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
# TLS note: AzuraCast is reached over its internal-only self-signed cert
# (10.10.30.104), so curl uses -k here. Fine on this trusted internal
# network; would not be fine crossing a public network.

set -euo pipefail

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
python3 -c '
import json, sys
json.dump({
    "text": sys.stdin.read(),
    "model_id": "eleven_multilingual_v2",
    "output_format": "mp3_44100_128",
    "voice_settings": {
        "stability": 0.6,
        "similarity_boost": 0.8,
        "style": 0.15,
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

echo "Uploading to AzuraCast (station ${AZURACAST_STATION_ID}) at ${DEST_PATH}..." >&2
python3 -c '
import base64, json, sys
path, audio_path, out_path = sys.argv[1], sys.argv[2], sys.argv[3]
with open(audio_path, "rb") as f:
    data = base64.b64encode(f.read()).decode("ascii")
with open(out_path, "w") as f:
    json.dump({"path": path, "file": data}, f)
' "$DEST_PATH" "$TMP_AUDIO" "$TMP_UPLOAD_PAYLOAD"

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

echo "Uploaded successfully." >&2
cat "$TMP_BODY"

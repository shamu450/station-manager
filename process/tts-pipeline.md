How to turn something you want to say into an actual clip in rotation.

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
true`, `play_per_songs` cadence (interrupts the main rotation every N
songs, tune via `PUT /api/station/{id}/playlist/32` as more clips exist -
started at 20 since one clip repeating too often gets old fast), enabled
alongside `0-Everything`. To add an uploaded file to it:

```
curl -sk -H "X-API-Key: $AZURACAST_API_KEY" -H "Content-Type: application/json" \
  -X PUT "$AZURACAST_BASE_URL/api/station/$AZURACAST_STATION_ID/file/<media_id>" \
  -d '{"playlists": [{"id": 32}]}'
```

`<media_id>` is the `id` field `generate_and_upload.sh` prints on success.
More interstitial playlists (by category - intros, trivia, back-announce)
can follow the same pattern once there's enough content to want separate
cadences per category rather than one shared pool.

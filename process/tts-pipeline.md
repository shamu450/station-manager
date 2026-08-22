How to turn something you want to say into an actual clip in rotation.

**Before you write one:** read [`clip-scripts.md`](clip-scripts.md), which
holds the full text of everything already on air. **After you generate one:**
add it there. Six clips went to air before that file existed and their words
are unrecoverable - the audio is the only copy.

Rough sizing: **~12 characters of script per second of audio**, measured
across three clips. 45 seconds is a good default; a clip a listener meets
every hour shouldn't run to a minute without a reason.

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

## Writing for pacing - real feedback, 2026-08-22

The station owner reported pacing trouble and stumbling on some clips.
Voice settings got a first tuning pass the same day (see
`generate_and_upload.sh`), but the script text you write matters just as
much as the API settings:

- Write full sentences with real punctuation - periods, commas - not one
  long run-on line. The model uses punctuation as its main pacing cue.
- Break a long thought into two shorter sentences rather than one with
  three clauses.
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

Working notes on the AzuraCast API - the endpoints that actually exist and
work with this key, and the ones that don't. Written after the 8th wake
burned most of a session guessing at undocumented query params and gave up.

## Every call needs `curl -k`

AzuraCast is reached at its internal address on a self-signed cert. Plain
`curl` returns **exit 60, empty body** - which looks exactly like an API
failure or an auth problem if you pipe it straight into a JSON parser.
It isn't. Add `-k`.

```
set -a; . ~/.config/station-manager/env; set +a
curl -sk -H "X-API-Key: $AZURACAST_API_KEY" "$AZURACAST_BASE_URL/api/station/$AZURACAST_STATION_ID/..."
```

## Play history - the one to reach for first

```
GET /api/station/{id}/history
```

Returns every play going back roughly two weeks (6,068 rows when first
used), each with `played_at`, `duration`, `playlist`, `is_request`, and the
full `song` object. No params needed.

This is how you answer "is the rotation actually doing what I configured,"
and it went unused for the station's first eight wakes while three separate
sessions set cadence numbers by guess. Two things worth knowing when
reading it:

- **Actual airtime is the gap to the next row's `played_at`, not
  `duration`.** Comparing the two is how you spot tracks that got cut off.
- **`playlist` is empty exactly when `is_request` is true.** Requests don't
  belong to a playlist, so don't mistake blank-playlist rows for a
  rotation bug - filter them out before measuring rotation behaviour.

## Finding media

```
GET /api/station/{id}/files?searchPhrase=<text>
```

Matches artist/title/path and returns full media records **including each
file's `playlists` array** - which is what you need to answer "is this
track actually in rotation, or only in a disabled playlist."

Not to be confused with `/files/list`, which browses real disk directories
and takes `currentDirectory`. That one is why the 8th wake couldn't find
the dumps: on disk they're `remote/music.dump/` and `remote/music-ipod/`,
not the playlist names `00-music-dvd-dump` / `00-music-ipod-dump`.

## Full metadata census for a playlist

```
GET /api/station/{id}/playlist/{id}/export-config
```

Returns every media record in the playlist (path, artist, title, album,
genre) plus the playlist's own settings and the station `backend_config`.
This is a complete census, so prefer it over sampling - a 223-file sample
of `00-music-dvd-dump` produced a 53% blank-album figure that the full
13,291-file census put at 10%, because the sample was loose top-level files
and those are the least-tagged ones in any folder.

Size scales with the playlist: ~4MB for 7,373 songs, ~20MB for the 35,514
in `0-Everything`. Write it to a file and parse it there rather than
holding it in context.

## Writing playlist settings

```
PUT /api/station/{id}/playlist/{playlist_id}   -d '{"field": value}'
```

Partial bodies work - send only the field you're changing. **Verify by
diffing the whole object before and after**, not by trusting the
`{"success": true}` response, and not by re-reading only the field you
set. That's how you catch a partial PUT quietly clearing something else.

## Known-unavailable with this key

- `GET /queue` - 403. Not in the granted role.
- `reports/duplicates` - 405 on GET.
- `POST /api/station/{id}/media` - 405; media upload goes through
  `POST /files` (see `generate_and_upload.sh`).

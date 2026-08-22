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
- **`sh_id` is a dense sequential counter.** No gaps across 6,091 rows, so
  the history is complete - every track the AutoDJ started is logged. You
  can trust a count from it.
- **History rows carry no media id - join on `unique_id`, which is hiding in
  the `art` URL.** `song.art` ends in `/art/<unique_id>`, and that value
  matches `unique_id` on the media record (and on the `media` dict from
  `export-config`). That is the only reliable key between "what aired" and
  "which file"; `song.id` is a hash of the *tags*, so two different files
  with identical artist/title/album collapse to one `song.id`, and a file
  whose tags get fixed changes its `song.id` without changing the file.

```python
uid = row["song"]["art"].rsplit("/", 1)[-1].split("-")[0]
```
- **Every row also carries `listeners_start`, `listeners_end` and
  `delta_total`.** This is the only audience data available anywhere, and
  it went unread for eleven wakes. It answers "when is anyone actually
  listening" and "did that track/clip cost us a listener" per play. First
  measurement 2026-08-22: mean 0.77 listeners, dead hour 06:00-07:00 ET
  (0.11), peak 10:00-15:00 ET, 3+ concurrent listeners 9 times in 14 days.
  Baseline is roughly one listener (the owner's own stream), so treat any
  single-play delta as noise and only read aggregates.

### Short plays are manual skips, not a station fault - resolved 2026-08-22

The 9th wake flagged "4.1% of plays get cut off under 30 seconds" as a
chronic unexplained defect. It isn't a defect. Don't re-open it as one.

Two corrections to how that number was computed, then the actual finding:

- 17% of the short plays are just **short files** (skits, outros, drops).
  Filter on `duration > 35` before calling anything a cut-off. Real
  cut-offs are 3.4% of plays, not 4.1%.
- The remaining cut-offs are **human skips at the dashboard**. The
  evidence, in descending order of strength:
  - **1,461 consecutive plays between 08:00-13:00 UTC (04:00-09:00
    Eastern), across all 14 days, contain exactly zero cut-offs.** At the
    overall 3.4% rate you would expect ~50. Probability of zero is about
    10^-22. Nothing environmental respects a sleep schedule that precisely.
  - 62% of cut-offs fall in 20 bursts (3+ within five minutes) - the shape
    of someone clicking through tracks, not of random failure.
  - Cut-offs are 2.6x more likely within 30 minutes of a listener request
    (26% vs a 10% baseline) - i.e. clustered around a human at the
    interface.
  - Victims span every storage folder (`remote/music/`,
    `remote/music.dump/`, `remote/music-ipod/`, `interstitials/`), and
    **26 of them have clean full plays elsewhere in the history**. So it is
    not bad files or one bad folder.

    *Corrected 2026-08-22 (11th wake):* this bullet previously also claimed
    a 43-second TTS clip "plays fine every other time." It doesn't — that
    clip has exactly one play on record and that play is the cut-off. Six
    interstitial plays existed in total, so no per-file pattern was
    available to assert. The 26-tracks figure is the sound version of the
    same argument and was already in hand.
  - Not caused by this role's own API writes: 23 of 24 cut-offs on
    2026-08-22 fell outside every wake window, and the single largest
    burst (24 cut-offs, 2026-08-08) predates the project.

Practical consequence: a skip is a **taste signal**, and the history is the
only place it's recorded.

*Corrected 2026-08-22 (13th wake):* this paragraph used to go on to say that
repeatedly-skipped tracks "are candidates for `z-not-wanted`, but confirm
with the station owner first." That has since been asked and **answered no**,
and CLAUDE.md now rules it out directly - `z-not-wanted` is a wrong-genre
list, never a taste list, and a track the owner skips is his taste, not a
curation defect. Bad rips go to `z-need-replacement`, a different playlist
for a different problem. Don't build a skip-to-playlist pipeline of any
kind off this data. If skip history ever looks genuinely useful, raise it
with him explicitly rather than routing it through a playlist that already
means something else.

### `avoid_duplicates` matches the raw artist tag, not a normalized one

73 artists in this library are split across more than one tag spelling
(`2Pac`/`2pac`, and `Jay-Z`/`JAY-Z`/`Jay-z`/`JAY‐Z` - that last one with a
Unicode U+2010 hyphen). AzuraCast compares the strings as stored, so a
split artist defeats duplicate prevention. Measured cost over 14 days: 2 of
15 back-to-back artist repeats and 12 of 91 within-four repeats slip
through. Normalize case and hyphens yourself when *measuring* repeat rates,
but don't assume the station backend does.

## Uploading over an existing path replaces the file in place

`POST /files` with a `path` that already exists does **not** create a
duplicate or a new record. Verified 2026-08-22 by uploading twice and
diffing: same `id`, same `unique_id`, playlist membership intact, only
`length` updated to match the new audio. That's what makes it safe to fix
the audio of a clip that's already in rotation without any playlist surgery.

**But the waveform is cached against `unique_id`, which doesn't change.**
After replacing a file, `GET /waveform/{unique_id}-0.json` keeps serving the
*old* shape - it showed the pre-fix waveform for all nine interstitials
minutes after they'd been replaced, while `length` on the media record had
already updated. Don't verify a media replacement from the waveform. Fetch
`/file/{id}/play` and check the bytes.

## Reading audio without any audio tools

There is no `ffmpeg`, `ffprobe`, `sox` or `mp3info` on this box, and no
`pip`. Two ways around it, both used 2026-08-22:

```
GET /api/station/{id}/waveform/{unique_id}-0.json
```

Returns peak data as interleaved min/max pairs, one pair per pixel, with
`samples_per_pixel` and `sample_rate` to convert to seconds (2205/44100 =
0.05s per pixel). This is enough to measure leading and trailing silence,
peak level, and roughly where speech starts - i.e. to "look at" audio you
can't listen to. Cached, see the warning above.

**`data` is already normalized floats in `[-1.0, 1.0]`. Do not scale it.**
The payload also carries `"bits": 8`, which describes the *source*
resolution, not the units of `data` - dividing by `2**(bits-1)` shrinks
every value 128x. The 14th wake did exactly that and got a peak of 0.008 on
eight consecutive files before noticing that eight identical readings meant
a bug, not eight identical files. If every file in a batch reports the same
implausible number, suspect your units before your data.

```
GET /api/station/{id}/file/{id}/play
```

Returns the raw file. MP3 is frame-structured and parseable in plain Python
(`process/pad_silence.py` has a working frame parser) - frame count times
1152 / sample rate gives an exact duration, and an all-zero frame body is
digital silence. Authoritative where the waveform is cached.

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

## This library is loud, and level analysis cannot find a bad rip in it

Measured 2026-08-22 (14th wake) across a random sample of 119 rotation
tracks over 90 seconds, via the waveform endpoint:

| metric | p50 | p75 | p90 | p95 | max |
|---|---|---|---|---|---|
| % of track pinned at full scale | 6.3 | 15.7 | 28.4 | 43.4 | 79.5 |
| mean amplitude | 0.61 | 0.70 | 0.80 | 0.85 | 0.94 |
| amplitude in the final second | 0.003 | 0.22 | 0.50 | 0.64 | 0.87 |

**Half this library clips.** 52% of tracks spend more than 5% of their
length at full scale, 18% more than 20%. That is what a collection of
2000s mixtapes and loudness-war masters looks like, and it is normal here.

**29% of tracks end at high amplitude**, so "stops at full level" is an
ordinary hard ending, not evidence of truncation. Only something extreme
(the worst case found was 0.965 in the final second) means anything.

The practical consequence, and the reason this table exists: the five files
the owner had marked `z-need-replacement` were checked against this
distribution and **three of them are cleaner than the library median** (0.04,
0.02 and 5.2% clipped, against a median of 6.3). Whatever makes a rip "bad"
to him - a DJ drop over the track, a mislabel, a skip, a lo-fi source - it
is not visible in level statistics. **Do not build a bad-rip detector on
clipping, peak or tail amplitude.** It would flag half the station and still
miss the actual defects.

Frame-level structure was clean on all eight files examined too: no sync
losses, no unparsed bytes, and frame-count duration matching the media
record's `length` to a tenth of a second in every case.

## Rotation structure - what actually airs, verified 2026-08-22

Only four playlists are enabled. Their media sets were compared directly:

- **`0-Everything` (18) is exactly the union of the three dump playlists** -
  `00-music` (14,849) + `00-music-dvd-dump` (13,283) + `00-music-ipod-dump`
  (7,372) = 35,504, with **zero overlap between the dumps** and zero
  members from anywhere else. Set equality, not just matching counts.
- **`reggae` (24) and `r-and-b` (10) are almost disjoint from it** - 4 of 38
  and 1 of 248 respectively. They are *additional* pools, not subsets, even
  though their files sit in the same `remote/music*` folders on disk. So
  their `play_per_songs` cadence adds genre content rather than
  redistributing what was already there.
- **The disabled `z-` buckets really do keep things off air.** Of 3,578
  files across the six of them, 8 leaked into `0-Everything` - and 5 of
  those (all `z-need-replacement`) were removed from playlist 18 in the
  14th wake. `z-duplicates` (1,077) and `z-not-wanted` (413) leak nothing.

This was re-derived from scratch in the 14th wake because the 9th wake's
version of it lived only in a `daily/` entry. **`daily/` is not loaded on
wake; `MEMORY.md` and `process/` are.** Durable findings go here.

## Check `nowplaying` right after any write, and again before you finish

```
GET /api/nowplaying/{station_id}
```

Returns `is_online`, `listeners.current`, the current and next track, and a
100-row `song_history` - and unlike `/history` it's small and fast, so it's
the right call for "is the station actually up." `/api/station/{id}/status`
only reports `backendRunning` / `frontendRunning`, and **both stayed `true`
through a real 11-minute silence**, so it is not a liveness check.

The 14th wake found the stream offline only because it ran this check at the
end of the session, twenty minutes after the drop-out began, and nearly
filed a wake-log saying "no regressions" while the station was silent.
**Make it routine: once immediately after writing to a playlist, once before
you finish.**

### Baseline for playback gaps

Measured over 6,334 plays / 14.6 days, comparing each track's end
(`played_at + duration`) to the next track's `played_at`: **8 gaps of two
minutes or more**, the largest **13.4 minutes on 2026-08-12**. Some days
have three. So a multi-minute silence is not automatically a fault or
automatically your fault - but check it against this baseline before
concluding either way.

Suspected but unproven: five sequential `PUT /file/{id}` writes against
`0-Everything` (35,499 entries) at 18:10 UTC on 2026-08-22 were followed 68
seconds later by an 11.8-minute gap, after 40 gapless minutes. Each write
makes AzuraCast regenerate that playlist for Liquidsoap. Prefer fewer
writes against the big playlist, and watch for a repeat.

## Removing media from one playlist without disturbing the others

`PUT /file/{id}` with `playlists` **replaces the entire array**. To take a
file out of one playlist you must send its full remaining membership, not
an empty list - otherwise you also strip the buckets that record why it was
flagged in the first place.

```
PUT /api/station/{id}/file/{media_id}  -d '{"playlists":[{"id":5},{"id":13}]}'
```

Used 2026-08-22 to drop five files from `0-Everything` (18) while keeping
both their source dump and their `z-need-replacement` (5) marker intact.
Only `mtime` changed alongside `playlists` on all five. Reversing it is one
PUT that adds 18 back.

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

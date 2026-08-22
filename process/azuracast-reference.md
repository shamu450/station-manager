# AzuraCast reference

Distilled from AzuraCast's own docs and source, scoped to what actually
matters for managing this station's media and playlists - not the full
docs site (most of it is install/hosting/admin material outside this role).

## Playlist fundamentals

**Sources a playlist can have:**
- `songs` - media files you manage directly (the normal case).
- `playlists` (**Grouped/Nested Playlists**, added 2026-08-15 - see below).
- `remote_url` - relays an external stream.
- `requests` - plays whatever listeners have requested; when empty, AutoDJ
  skips to the next eligible playlist. Duplicate-prevention doesn't apply
  here in spirit - a request is a request, not the AutoDJ discovering a
  repeat.

**Playlist types (cadence, not to be confused with the sources above):**
- `default` (General Rotation) - competes with other `default` playlists by
  `weight` (1-25, higher = more often).
- `once_per_x_songs` / `once_per_x_minutes` / `once_per_hour` - fixed
  cadence, ignores weight.
- `custom` (Advanced) - hand-written Liquidsoap config; AzuraCast still
  manages the playlist's contents via the web UI, but won't auto-generate
  the rotation logic. Power-user escape hatch, not needed for anything
  we're doing.

**`is_jingle` and `avoid_duplicates`** are already documented in `CLAUDE.md`
and `tts-pipeline.md` from hard lessons - not repeated here, see those.

## Grouped/Nested Playlists ("Clockwheels") - new, 2026-08-15

A playlist can itself be built from *other playlists* instead of raw media
(`source: playlists`). Each member playlist gets its own `weight` or
`type`/cadence within the group, same options as a normal playlist. This is
the no-code alternative to the old `custom`/Advanced escape hatch, and it's
newer than most of what's in this project's own history - the original
project plan (2026-08-21) picked this as "the right fit" for scheduling
interstitials, but what actually got built instead was `is_jingle` +
`play_per_songs` on individual playlists. Worth a real look at whether
grouping interstitials/reggae/r-and-b under a group playlist would replace
some of the current per-playlist cadence tuning with something more direct
- not decided, flagged for evaluation.

## Crossfade eats the first two seconds of everything

`backend_config.crossfade = 2.0` on this station. Two numbers come out of
that one setting, and both matter for spoken clips:

- **fade ramp = 2.0s.** The incoming track's volume is ramped up from zero
  over two seconds.
- **overlap window = 3.0s**, because `getCrossfadeDuration()` returns
  `crossfade * 1.5`. The outgoing track is still audible that whole time.

For music this is invisible - songs have intros. For a spoken clip that
starts talking at t=0 it destroys the opening words, which is exactly what
the station owner heard on the station ID and marked `<broken audio>`.

**There is no per-file escape hatch.** A media record's `extra_metadata`
carries `fade_in`, `fade_out`, `cue_in`, `cue_out`, `cross_start_next` and
`amplify`, and it is tempting to set `fade_in: 0` on a jingle. That does not
work: in `azuracast.liq`, `live_aware_crossfade_impl` passes
`settings.azuracast.default_fade()` - the station-wide value - to
`cross.smart`, `cross.simple` and the plain `add` fallback alike. The
per-file values feed the separate **autocue** path (`autocue_fade_in`), not
this one. Changing the station-wide value is out of this role's scope
anyway.

So the fix is to pad the audio itself. `process/pad_silence.py` does it and
`generate_and_upload.sh` calls it on every generation.

**All nine clips on air were padded once, on 2026-08-22. Padding is not
idempotent** - a second bulk pass would give them four seconds a side.
Check for 77 leading all-zero MP3 frames (2.01s) before padding anything
that has been in rotation since then.

While confirming the above, `azuracast.handle_jingle_mode` was read
directly: it replaces a jingle's metadata with the previous track's and does
nothing else. Independent source-level confirmation of what CLAUDE.md
already says about `is_jingle` - it is metadata hiding, never cadence and
never fades.

## Media management

- A file must be in at least one playlist to ever get played by the
  AutoDJ - files can sit in the media library unassigned, but they're
  invisible to rotation until added somewhere.
- Auto-assign folders: select a folder in the Media Manager, "Set
  Playlists," and anything added to that folder afterward joins those
  playlists automatically. Additive only - it won't remove a file from a
  playlist the folder assignment doesn't include.

## Station structure (why two "backends" exist)

- **AutoDJ** (Liquidsoap) composes the actual stream from playlists/live
  input and transcodes it. Listeners never connect to it directly.
- **Broadcasting software** (Icecast, this station's setup) takes the
  AutoDJ's signal and serves it to listeners at scale. This is the layer
  Mount Points sit on.
- Both are kept running automatically; most config changes apply live
  without a restart.

## Mount points

One station can expose the same broadcast at multiple formats/bitrates
(e.g. different MP3 bitrates) via separate mount points. Not something
this station's DJ role manages, but useful to know what a "mount point"
actually is when it comes up.

## Streamers & DJs (live human broadcasters) - not our use case

This is AzuraCast's feature for a live human connecting broadcast software
(Mixxx, BUTT, etc.) directly to the AutoDJ for real-time shows. We generate
pre-rendered clips and upload them via the Files API instead - this
feature doesn't apply to how this station's DJ operates. Noted here only
so it's not mistaken for something to configure.

## Logs, if something breaks

`Log Viewer` under a station's `Utilities` menu (dashboard UI, not
currently exposed to this API key's scoped role) surfaces the IceCast,
SHOUTcast and Liquidsoap logs plus their generated config. If the station
role ever gets that permission, that's where to look before guessing.

## Staying current - rolling release, check daily

AzuraCast ships continuously (no meaningful version tags since 2023), so
"what's new" lives in `AzuraCast/AzuraCast`'s own `CHANGELOG.md`, in the
**Rolling Release Changes** section at the top of the file - features and
fixes that have landed but haven't been bundled into a dated release
section yet.

**Check it roughly daily** (once per day is enough, doesn't need to be
every wake): fetch
`https://raw.githubusercontent.com/AzuraCast/AzuraCast/main/CHANGELOG.md`
and compare the Rolling Release Changes section against what's recorded
below. If it changed, read what's new, fold anything operationally
relevant into this file, and update the checkpoint.

**Last synced:** 2026-08-22 (12:15 UTC, 12th wake). Rolling Release Changes
still covers exactly the same four items - Grouped/Nested Playlists, Request
Queue Playlists, Block Requests During Schedule Blocks, Playlist JSON
Importer/Exporter - with no additions since the previous check. Most recent
dated release below it is 0.23.8 (2026-08-09).

Note the docs *site* (`azuracast.com/docs/...`) returns 403 to WebFetch.
Read the source on `raw.githubusercontent.com` instead - and for anything
about how the stream is actually assembled, the Liquidsoap scripts under
`util/docker/stations/liquidsoap/` are more truthful than any prose. The
repo tree lists via
`api.github.com/repos/AzuraCast/AzuraCast/git/trees/main?recursive=1`;
note PHP sources live under `backend/src/`, not `src/`.

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

**Last synced:** 2026-08-22, `AzuraCast/AzuraCast` commit `2cb84e2f`,
`AzuraCast/azuracast-docs` commit `cff3a3c6`. Rolling Release Changes
section at that point covered: Grouped/Nested Playlists, Request Queue
Playlists, Block Requests During Schedule Blocks, Playlist JSON
Importer/Exporter.

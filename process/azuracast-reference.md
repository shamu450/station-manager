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

## Scheduling a playlist to a time window - first used 2026-08-22

Used for the first time in the 15th wake, for a one-night private event.
Everything below was read out of `backend/src/Radio/AutoDJ/Scheduler.php`
rather than inferred from the dashboard.

**Scheduling is orthogonal to `type`.** `Scheduler::shouldPlaylistPlayNow()`
checks `isPlaylistScheduledToPlayNow()` *first* and only then applies the
`type` cadence. So `type: once_per_x_songs` + `play_per_songs` + a schedule
window compose exactly as you'd hope: inside the window the cadence applies,
outside it the playlist is simply ineligible. A playlist with **no**
schedule items returns `true` from that first check, which is why every
existing playlist here plays around the clock.

**`schedule_items` does not save on `POST`. It only saves on `PUT`.**
Creating a playlist with `schedule_items` in the create body returns HTTP
200 and a perfectly normal playlist object with `"schedule_items": []`. The
schedule is silently dropped. Create the playlist first, then `PUT` the
schedule to `/playlist/{id}` as a second call. **Always read the playlist
back afterward** - this failure is completely silent and a schedule that
never saved means a playlist that plays *all the time*, which is the
opposite of what you asked for.

Item shape (times are `HHMM` integers in **station local time**, which the
scheduler takes from the station timezone - `America/Toronto` here, so all
the DST reasoning is handled for you):

```json
{"start_time": 2100, "end_time": 2200,
 "start_date": "2026-08-22", "end_date": "2026-08-22",
 "days": [], "loop_once": false}
```

- **`days: []` means every day** - `isScheduleScheduledToPlayToday()` is
  `empty($days) || in_array($day, $days)`. Only populate it if you actually
  want a weekday restriction; ISO numbering, 1 = Monday.
- **`start_date`/`end_date` are compared as `Y-m-d` strings against the
  date the *window* starts**, not against "today". They're inclusive.
- **Prefer two same-day items over one that crosses midnight.** A window
  where `start_time > end_time` sends the scheduler down a separate
  overnight branch that builds two candidate periods (yesterday→today and
  today→tomorrow), and the date range is then tested against whichever
  window start matched. It does work, but a 21:00→02:00 block dated to a
  single night is much easier to reason about split into `2100-2359` on
  night one and `0000-0200` on night two, each pinned to its own date.
  That also sidesteps needing to know which day-of-week an overnight block
  belongs to. Cost is a 60-second hole at 23:59; irrelevant in practice
  because the AutoDJ queues ahead.
- **Date-pinning is the off switch.** An event playlist whose items all
  carry `start_date == end_date == the night in question` can never fire
  again, with no cleanup step to forget.
- **Leaving both dates `null` is the on switch.** For a *recurring* daily
  block - a nightly show rather than a one-off event - send
  `start_date: null, end_date: null, days: []` and it runs that window
  every day indefinitely. Verified by read-back on `after-hours`
  (`0000-0600`, 18th wake), the station's first recurring schedule.
- **A scheduled playlist plays only inside its window.** So dayparting one
  pool into two behaviours means *two playlists*, not one with a clever
  setting. `interstitials-dj-loop` covers `0600-2359` at `pps 20` and
  `interstitials-overnight` covers `0000-0600` at `pps 30`, both holding
  the same twelve clips. The one-minute hole at 23:59 is the cost of
  avoiding a midnight-crossing window and does not matter - the AutoDJ
  queues ahead.

### Get the station's local date before you reason about any of these dates

**The environment this role runs in reports UTC. The scheduler runs in
`America/Toronto`.** For five hours every evening those are different
calendar days, and every `start_date` above is written in the station's day,
not the environment's.

This is not hypothetical. In the 16th wake three date-pinned event playlists
were pinned to the station's *current* local day while the environment
already reported the next UTC day. The conclusion drawn was "those windows
closed overnight, this is leftover clutter" - so all three were disabled,
**under an hour before the first one was due to fire**. They were restored
about three minutes later, before any window opened, and only because
stamping the wake-log's Eastern front matter forced a
`TZ=America/New_York date` call that showed the real date.

Knowing the rule was not enough - the previous wake had read
`Scheduler.php`, confirmed schedules evaluate in station timezone, and
written it down two paragraphs above this one. The failure was never
converting the input.

So, mechanically, before touching a dated schedule:

```
TZ=America/New_York date +"%Y-%m-%d %H:%M"     # or read station.timezone
```

Related: `is_enabled` and `schedule_items` are independent fields.
Disabling a playlist does not clear its schedule, so a mistaken toggle is
fully recoverable by toggling back - verified in that same wake.

And the wider lesson, which is not about timezones: the risky-looking job
that wake (a 2,701-file batch write) got a reverse membership map, a
54-record validation pass, create-disabled-first and a full count check, and
went clean. The station was nearly broken by a one-line tidy-up performed on
the way past, with no verification beyond reading a date. **Match care to
what a change can break, not to how large it feels.**

**`GET /api/station/{id}/schedule` cannot verify any of this for a jingle
playlist.** It returns `[]` and that is correct behaviour, not a fault:
`StationScheduleRepository::getAllScheduledItemsForStation()` filters on
`sp.is_jingle = 0 AND sp.is_enabled = 1`. That endpoint powers the
listener-facing "what's on" calendar, and jingles aren't programming. It is
a *reporting* query and shares no code with the eligibility path above.
Don't spend a wake wondering why a correct schedule looks empty there.
Verify by reading `schedule_items` back off the playlist instead.

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

**Last synced:** 2026-08-23 (12:30 UTC / 08:30 ET, 18th wake). Rolling
Release Changes still covers exactly the same four items - Grouped/Nested
Playlists, Request Queue Playlists, Block Requests During Schedule Blocks,
Playlist JSON Importer/Exporter - with no additions since the previous
three checks. Most recent dated release below it is 0.23.8 (2026-08-09).

Note the docs *site* (`azuracast.com/docs/...`) returns 403 to WebFetch.
Read the source on `raw.githubusercontent.com` instead - and for anything
about how the stream is actually assembled, the Liquidsoap scripts under
`util/docker/stations/liquidsoap/` are more truthful than any prose. The
repo tree lists via
`api.github.com/repos/AzuraCast/AzuraCast/git/trees/main?recursive=1`;
note PHP sources live under `backend/src/`, not `src/`.

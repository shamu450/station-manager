Index of what you've learned across wakes. One line per entry, detail in the
linked file. This file loads every wake - keep it short.

- 2026-08-21: identity chosen (Selah / DJ Loop, explicit-AI stance,
  personality, voice shortlist, domain preference) - full detail in
  `identity.md` at repo root, not duplicated here.
- 2026-08-21: all three `seeds/` sources read in full - distilled notes in
  `seeds/anthology-of-rap.md`, `seeds/cant-stop-wont-stop.md`,
  `seeds/the-big-payback.md`.
- 2026-08-21: voice pick still open - waiting on the station owner to listen
  to the shortlist in `identity.md` and say which one.
- 2026-08-21 (2nd wake): `wake.sh` graduated to cron, daily 12:00 UTC - see
  `daily/2026-08-21-2.md`.
- 2026-08-21 (2nd wake): live AzuraCast rotation surveyed for the first
  time - only `0-Everything` (35,514 songs) is enabled; everything else
  (genre splits, cleanup buckets) is disabled and unreviewed. No changes
  made. Full detail in `daily/2026-08-21-2.md`.
- 2026-08-21 (5th wake): voice decided (Empress, `MHPwHxLx0nmGIb5Jnbly`) and
  tested in an untracked session before this one; this wake put the first
  real clip into live rotation - `interstitials-dj-loop` playlist (id 32,
  jingle, `play_per_songs: 20`). Domain landed as `djloop.ca`, not the
  `djloop.fm` preference. Cron is `0 */4 * * *`, not daily. A real
  wake-log gap exists for 3 earlier commits (playlist/media-deletion rule,
  wake-log-site wiring, TTS pipeline docs) - flagged, not backfilled. Full
  detail in `daily/2026-08-21-5.md`.
- 2026-08-22: added a second interstitial (Kool Herc/dub trivia, media id
  76684) to playlist 32, so the pool is 2 clips / 60s instead of 1.
  `play_per_songs` left at 20 - still tuning by clip count, not the cadence
  number, until there are 4-5 clips. Full detail in `daily/2026-08-22.md`.
- 2026-08-21 (6th wake): built `raw-journal.md` (unbuilt since day one per
  CLAUDE.md). Fixed a real site bug - `_config.yml` never had
  `timezone: America/New_York` set, so every "ET" timestamp was actually
  rendering in UTC despite an earlier front-matter fix; also caught that
  `daily/` filenames were keyed to UTC date, not Eastern, and switched to
  Eastern-date filenames going forward (not renaming old files). Added a
  third interstitial (Rakim's internal-rhyme innovation, media id 76685) -
  playlist 32 now 3 clips / 95s. Full detail in `daily/2026-08-21-6.md`.
- 2026-08-21 (7th wake): enabled the long-dormant `reggae` (38) and
  `r-and-b` (243) playlists, and surveyed `0-Everything`'s composition
  (`00-music` + `00-music-dvd-dump` + `00-music-ipod-dump`). Both cadence
  settings used here were wrong and got corrected in the two wakes after -
  see CLAUDE.md's `play_per_songs`/`is_jingle` entries before reusing
  anything from this one. 4th clip (Duke Bootee, media 76686). Full detail
  in `daily/2026-08-21-7.md`.
- 2026-08-21 (8th wake): fixed `type: default` -> `once_per_x_songs` on
  playlists 32/24/10, which is what actually makes `play_per_songs` do
  anything; reggae 30->100, r-and-b 25->80. Burned the session guessing at
  undocumented media-API query params and gave up - unblocked in the 9th.
  Full detail in `daily/2026-08-21-8.md`.
- 2026-08-22 (9th wake): first use of the play-history API, which had sat
  unused for eight wakes; undid the `is_jingle` mistake on reggae/r-and-b
  and enabled `avoid_duplicates` on `0-Everything`. Corrected its own
  earlier dvd-dump metadata figures via a full census, closed the
  ipod-dump question (it's clean), and identified the Spider Loc repeat as
  the owner's stereo-tools request loop. 5th clip (Grandmaster Caz, media
  76687). Full detail in `daily/2026-08-22-2.md`.
- 2026-08-22 (10th wake): **short plays are manual skips, not a station
  fault** - the "4.1% truncation" carried as an unexplained defect for two
  wakes is resolved and should not be re-opened as a bug. Method and
  evidence in `process/azuracast-api.md`. Also: `avoid_duplicates` matches
  the raw artist tag, and 73 artists are split across spellings, so it's
  ~87% effective. Interstitial cadence closed at `play_per_songs: 20`
  (measured 1 per 24 songs). 6th clip (media 76688). Full detail in
  `daily/2026-08-22-3.md`.
- Standing habit that keeps paying off: **cross-tab by time-of-day early**
  when asking "is this a fault or a person?" It's the cheapest test for a
  human in the loop and the 10th wake reached for it fourth, not first.

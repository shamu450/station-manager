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
- 2026-08-22 (11th wake): **the library has a real Canadian catalogue** -
  Classified 198 tracks, Kardinal Offishall 108, Dream Warriors 71,
  Rascalz 38, Choclair 32, Maestro Fresh Wes 23, plus *Cash Crop* and both
  "Northern Touch" cuts. Unmentioned for ten wakes on a `.ca` station.
  Three clips made (76689/76690/76691), pool now 9 clips / 379s. Started
  `process/clip-scripts.md` - six clips had gone to air with no record of
  their words anywhere. Corrected a wrong supporting detail from the 10th
  wake (the Duke Bootee clip has one play ever, not several). First
  measurement of `listeners_start`/`listeners_end`. Full detail in
  `daily/2026-08-22-4.md`.
- 2026-08-22 (12th wake): **the station's 2.0s crossfade had been eating the
  opening words of every clip since the first one** - all nine were
  generated with <0.10s of leading silence. Fixed by padding real silence
  into the audio (`process/pad_silence.py`, now called by
  `generate_and_upload.sh`); there is no per-file fade escape hatch. Also:
  uploading over an existing path replaces in place (id/playlists intact),
  the waveform endpoint is cached against `unique_id` so it can't verify a
  replacement, and `eleven_v3` works and appears to bill at half rate. Full
  detail in `daily/2026-08-22-5.md`.
- 2026-08-22 (13th wake): **re-cut all 8 remaining clips onto `eleven_v3`**
  at the owner's request (the 12th wake had padded them but only re-cut the
  station ID - padding is not regenerating). He transcribed clips 2/3/4 by
  ear, so **every clip on air now has a real script written down**. Killed
  the sentence-pause pacing model, confirmed half-rate billing, and found
  that v3 runs 15-35% longer than the old model. Full detail in
  `daily/2026-08-22-6.md`.
- 2026-08-22 (14th wake): **five files marked `z-need-replacement` were also
  in `0-Everything` and airing** - removed from playlist 18 only, markers
  and dump membership intact (35,504 → 35,499). Flagged in five consecutive
  wakes before anyone acted. Also: tried to confirm they were defective from
  the audio and **couldn't** - see the clipping-baseline entry below. Full
  detail in `daily/2026-08-22-7.md`.
- 2026-08-22 (15th wake): **first deadline wake** - a private request in
  `talk.md` with under two hours to deliver. Seven clips (76694-76700) and
  three date-pinned scheduled playlists (33/34/35). Details of that request
  are private and are not recorded in this repo; see `~/private-clips/` on
  this box. Also built **`canadian` (playlist 36), 535 tracks / 33h**,
  `once_per_x_songs` at 10 - the Canadian catalogue was in the library all
  along. Detail in `daily/2026-08-22-8.md`.
- 2026-08-22 (16th wake): built **`golden-era` (playlist 37), 2,701 tracks /
  188h**, `once_per_x_songs` at 5 - the station's stated format (1988-2001)
  had no privileged place in rotation until now. Also **disabled three live
  event playlists by mistake and restored them 3 minutes later** - see the
  timezone bullet below. Detail in `daily/2026-08-22-9.md`.
- 2026-08-23 (17th wake): built **`two-thousands` (playlist 38), 2,459
  tracks / 161h**, `once_per_x_songs` at 10 - closing an imbalance the 16th
  wake created by giving 1988-2001 a guaranteed slot and the other half of
  the stated format none. 11th clip (media 76701). Detail in
  `daily/2026-08-23.md`.
- 2026-08-23 (18th wake): built **`after-hours` (playlist 39), 1,438
  tracks / 134h**, `once_per_x_songs` at 4, **scheduled 00:00-06:00 every
  night** - the station's first recurring schedule and the first time it
  sounds different at one hour than another. Also dayparted the talking
  (`interstitials-dj-loop` 32 now 06:00-23:59 at pps 20;
  `interstitials-overnight` 40, same 12 clips, 00:00-06:00 at pps 30) and
  cut the 12th clip (media 76702) as a block *promo* that reads correctly
  at any hour. Detail in `daily/2026-08-23-2.md`.
- 2026-08-23 (19th wake): built **`selah-weekend-nights` (playlist 41), 207
  tracks / 14.5h / 67 artists**, `once_per_x_songs` at 3, **scheduled
  Fri+Sat 20:00-23:59** (`days: [5,6]`) - the station's first *day-of-week*
  shape, and the first pool built from a hand-written list of records
  rather than a metadata predicate. 13th clip (media 76703). First fires
  2026-08-28. Detail in `daily/2026-08-23-3.md`.
- **A filter can be 27-for-29 right and still be catastrophically wrong.**
  The 120-420s band on that pool excluded 29 files: 27 were sub-2-minute
  DVD-dump fragments and cutting them was correct; the ceiling cut exactly
  two, one of which was **"The Message"** (432.8s), the most important
  record in the genre, by thirteen seconds. **Read what a filter threw
  away, not just what it kept** - a high hit rate is not evidence about the
  tail. Nearly published "your library is missing The Message" to the
  owner off it.
- **Normalize *subtitle* parentheticals too, not just version ones.** An
  exact match on a normalized title missed every record whose canonical
  title carries a parenthesised second half - "Ante Up (Robbing-Hoodz
  Theory)", "Many Men (Wish Death)", "Party Up (Up in Here)", "Hard Knock
  Life (Ghetto Anthem)". 65 of 122 apparent absences were this. Prefix
  match (`title == want or title.startswith(want + ' ')`) recovers them;
  still read the results, 5 of 21 were snippets, DJ blends or duplicates.
- **A tag-based absence is never evidence a record is absent.** Run-DMC's
  classics are in this library filed with **track numbers in the artist
  field** (`25 | Here We Go -- Run DMC`), and "Shook Ones Pt. II" is filed
  as "Shook Ones B/W Got It Twisted". Before telling the owner his
  collection lacks something, search title *and* path with the artist
  constraint dropped.
- **Paginated `/files` is the live membership map - use it, not
  `export-config`.** `?rowCount=2000&current=N` returns full live
  `playlists` arrays plus media ids; 20 requests covers all 39,668 files in
  under a minute. Same cost as one export, none of the staleness. Export is
  still the way to get a metadata census. In `process/azuracast-api.md`.
- **Building a pool from named records needs four things a metadata filter
  does not**: an artist qualifier per title (generic titles are the norm -
  "Warning" pulls six songs), **no** artist-level padding (it put 2 artists
  at 40% of the pool), dedupe on **title alone** (artist tags differ between
  copies, so "We Fly High" survived six times), and a mixtape-blend-credit
  filter. Also: **search the dumps for this kind of build** - the
  organized-collection-only rule is about metadata quality, and 66 of the
  207 anthems, including all of Public Enemy, Onyx, the Fugees and "The
  Message", exist *only* in the dumps. In `process/azuracast-api.md`.
- **Half the clip pool is now about the station rather than the music** (6
  of 13, and 12/13 are back-to-back block promos). Every new playlist feels
  like it needs announcing; it does not. Same drift as the credit-theft run
  at clip 6, different door. Register note updated in
  `process/clip-scripts.md`.
- **`export-config` is a cache and can be hours stale - never let a write
  depend on it alone.** `playlist/32/export-config` returned 10 records
  while the live `/playlists` said 11; the missing file had been added six
  hours earlier, and an identical re-fetch minutes later returned all 11.
  Nothing in the response signals this. It matters because
  `PUT /files/batch` has *set* semantics, so a membership the export omits
  is a membership the write silently deletes. **`/playlists` (`num_songs`)
  and `/files?searchPhrase=` are live; `export-config` is not.** Take a
  full `num_songs` census of *every* playlist before the write and diff all
  of them after - one cheap call each side, and it is what turned this into
  a finding instead of an incident. In `process/azuracast-api.md`.
- **The question is per-album vs per-track, not tags vs year.** Per-album
  properties (genre, year, artist, region) clump unless *every* album has
  one - which is why path year partitions evenly (2,459 tracks / 159
  artists) and the seven "mellow" genre tokens do not (759 tracks / **38
  artists**, top-5 = 55%). But `length` is per **track**, 100% populated,
  and beats both: `after-hours` is 1,438 tracks across **291 artists**,
  largest artist 4.2% - the flattest pool the station has. ~~A late-night
  block is not buildable until the library carries BPM or per-track
  tags~~ - **retired 18th wake**, it was generalised from a sample of two
  property kinds and `after-hours` disproved it six hours later. Before
  writing off an axis, ask whether any per-track property reaches it. Two
  gotchas: cap the top of a length filter (past ~10 min you get
  hidden-track files = song + minutes of silence + bonus cut = dead air),
  and keep title-exclusion regexes narrow (`\bhidden\b` cut a real song;
  `intro|outro|interlude|skit` is the safe set). In
  `process/azuracast-api.md`.
- **The `z-` exclusion buckets are cleanup of the *dumps*, not of
  `remote/music/`.** Zero of the 2,678 files in the 2002-2009 window sit in
  any of them; `z-skits` has 1,829 members and **2** live in
  `remote/music/`. A pool sourced from the organized collection needs
  almost no exclusion filtering - but still run the check, it's one set
  intersection, and `canadian` did lose 24 tracks to it because that pool
  reached into the dumps.
- **`once_per_x_songs` under-delivers by 8-25%, and it is structural - but
  do not tune on it.** Re-measured 18th wake over 108 plays in a **clean**
  window (the contaminating event playlists had closed): `golden-era`
  1-in-6.4 against a configured 5, `two-thousands` 1-in-12 against 10,
  `canadian` 1-in-12 against 10, `interstitials` 1-in-21.6 against 20.
  Smaller than the 12-40% the 17th wake measured in a contaminated window,
  so part of that figure *was* the event playlists and part is real.
  Everything lands low, nothing lands high, spread is consistent - most
  likely slot contention. Read `play_per_songs` as **"at most one in X"**
  and size against that instead of adjusting the numbers; three wakes are
  already on record tuning off samples that could not carry it.
- **Cap debug prints of per-file samples.** An uncapped artist-path dump put
  ~150 lines of one artist's discography into context for no gain. Print
  counts and a handful of examples.
- **The environment reports UTC; the station runs `America/Toronto`.** For
  five hours every evening they are different calendar days. The 16th wake
  compared a UTC date against Eastern-pinned `start_date` rows, concluded
  three live event playlists were expired clutter, and disabled them 48
  minutes before the first was due to fire. **Run
  `TZ=America/New_York date` before reasoning about any dated schedule.**
  Knowing schedules are station-tz did not help - the previous wake had read
  `Scheduler.php` and written it down; the input was just never converted.
  `is_enabled` and `schedule_items` are independent, so the toggle was
  recoverable. In `process/azuracast-reference.md`.
- **Match care to what a change can break, not to how large it feels.** Same
  wake: the 2,701-file batch write got a reverse membership map, a 54-record
  validation pass, create-disabled-first and full count verification, and
  went clean. The near-outage came from a one-line tidy-up done on the way
  past with no verification at all. The dangerous operation was the one that
  felt like housekeeping.
- **`genre` is multi-valued, 89.8% populated, 206 distinct tokens.** Eight
  wakes of parsing media records read it as a throwaway string. **Tokenize
  on `;` and `,`** - compound values like `Gangsta Rap, Hip Hop` fall
  through a semicolon-only split (cost 192 files on the first pass). But
  tags alone cannot build a pool here: they were applied per-album, so the
  six narrow boom-bap-ish tokens cover 1,042 files across only **35
  artists**, with no Nas, Mobb Deep, Pete Rock or De La Soul, while
  `east coast hip hop` is geography not era and brings in Bobby Shmurda.
  In `process/azuracast-api.md`.
- **The path tells you which collection you are standing in.**
  `remote/music/` is `Artist/Album (Year)/`, 57% carry a year;
  `remote/music.dump/` is bootlegs/mixtapes at 2%; `remote/music-ipod/` is
  unlabelled disc rips at 0%. **The two dumps are 57% of `0-Everything`**,
  so a flat shuffle plays more bootleg material than organized collection.
  Build metadata-dependent pools from `remote/music/` only, and gate on the
  **path year** rather than on genre.
- **Cut sub-100s files from any `once_per_x_songs` pool.** The 45-100s band
  is ~90% skits, interludes and radio drops that `z-skits` missed, and a
  guaranteed-slot playlist would hand them a guaranteed airing. Losing a few
  real short tracks costs nothing - they still play from `0-Everything`, so
  a pool cut removes nothing from the station.
- **`schedule_items` saves on `PUT` only - `POST` silently drops it.**
  Creating a playlist with a schedule returns 200 and `schedule_items: []`.
  The failure mode is not "never plays", it's **plays constantly forever**.
  Always print the response object, never just `%{http_code}`. Scheduling
  is orthogonal to `type` (window checked first, then cadence) and uses the
  station timezone. Prefer two same-day items over one midnight-crossing
  one, and pin `start_date == end_date` so an event playlist can't fire
  twice. In `process/azuracast-reference.md`.
- **`GET /station/{id}/schedule` filters `is_jingle = 0`** - it feeds the
  listener calendar and shares no code with the scheduler. An empty result
  for a jingle playlist is correct, not a fault. Verify schedules by
  reading `schedule_items` back off the playlist.
- **Bulk playlist assignment: `PUT /files/batch`** with `do: playlist` and
  storage-relative **paths** (not ids). Same replace-everything semantics as
  `PUT /file/{id}` (`setPlaylistsForMedia` is *set*, not *add*), so group
  files by existing membership and send `[...existing, new]` per group - 535
  tracks in 6 requests instead of 535. `do: 'delete'` lives on the same
  endpoint one string away; write it as a literal. In
  `process/azuracast-api.md`.
- **Search results need reading, not counting.** Building `canadian`,
  "Snow" returned 78 hits (all *Bishop* Snow), "Shad" 315 (DJ Shadow /
  ShadyBlock), "TOBi" 18 (Jeezy). `searchPhrase` matches artist/title/path,
  so always group hits by distinct artist string and eyeball them before
  acting. Ambiguous artist tags resolve from the track list: bare `Maestro`
  = Maestro Fresh Wes (via "Stick To Your Vision" / "416/905"), `Infinite`
  = the Toronto MC's *360°*.
- **Baseline the counter before you write to it.** The 15th wake found
  `0-Everything` at 35,484 against a documented 35,499 and could not say
  whether its own 535-file batch caused it, because no count was taken at
  wake start. Re-reading all 535 proved zero losses, but that was recovery,
  not method. Record the number you're about to change, first.
- **Rotation structure, verified by set comparison not assumption.**
  `0-Everything` is the *exact* union of `00-music` + `00-music-dvd-dump` +
  `00-music-ipod-dump` (35,504, zero cross-dump overlap). `reggae` and
  `r-and-b` are **not subsets of it** - 4/38 and 1/248 overlap - they're
  additive pools, so their cadence adds genre rather than reshuffling. The
  disabled `z-` buckets do work: 8 leaks out of 3,578 files. In
  `process/azuracast-api.md`.
- **Half this library clips - don't build a bad-rip detector on levels.**
  Across 119 random rotation tracks: median 6.3% of a track pinned at full
  scale, 52% of tracks over 5%, 18% over 20%, and 29% end at high amplitude
  (so "stops dead at full volume" is a normal hip hop ending, not
  truncation). Three of the five files the owner flagged as bad rips are
  *cleaner than the median*. Whatever "bad rip" means to him is not visible
  in level statistics.
- **Baseline before you judge a metric.** The clipping numbers on the
  flagged files looked damning until measured against the library's own
  distribution, which reversed the conclusion. Same failure shape as the
  dead 2.7s-per-sentence model: a decisive-looking metric with no null
  distribution behind it. This is the [[feedback_measure_before_tuning]]
  habit pointed at diagnosis rather than tuning.
- **Implausible *and* identical across a batch = check your units.** Eight
  files in a row reported peak amplitude 0.008; that was a 128x scaling bug,
  not eight quiet files. The waveform `data` array is already normalized to
  ±1.0 and `"bits": 8` describes source resolution, not the units of `data`.
- **`PUT /file/{id}` replaces the whole `playlists` array.** To remove a file
  from one playlist, read its current membership and send the rest - sending
  `[]` would also strip the `z-` bucket recording why it was flagged.
- **History rows carry no media id.** Join to media on `unique_id`, which is
  the last path segment of `song.art`. Don't use `song.id` - it's a hash of
  the tags, so it collapses distinct files and changes when tags are fixed.
- **`daily/` is not loaded at boot; `MEMORY.md` and `process/` are.** The
  14th wake re-derived the whole exclusion-bucket audit from scratch because
  the 9th wake's version of it lived only in a wake-log entry. The wake-log
  is written for the owner. Durable findings go in `process/` and get an
  index line here.
- **`/status` is not a liveness check** - `backendRunning` and
  `frontendRunning` both stayed `true` through a real 11-minute silence.
  Use `GET /api/nowplaying/{id}` (`is_online`), which is also small and
  fast. **Run it right after any playlist write and again before finishing
  a wake** - the 14th wake caught an outage 20 minutes late and almost filed
  "no regressions" while the stream was down. Gap baseline: 8 gaps ≥2min in
  14.6 days, largest 13.4min (2026-08-12, predates the project).
- **Clip pacing is not converging.** The measured char/s range widened at
  both the 13th and 14th wakes (8.86-11.73 over 14 takes, now 8.86-12.09
  over 15). Treat the observed range as a floor on the real spread, keep
  sizing at ~9 char/s. v3 half-rate billing confirmed a third time
  (461 → 231).
- ~~A full stop costs 1.5-2 seconds of audio~~ - **retired 13th wake.** That
  was a two-point fit to two takes of one script, and it under-predicted the
  next clip by 25%. Across 14 takes v3 delivery is **8.86-11.73 char/s**
  (mean 10.23) and one re-cut 74 characters *shorter* came back 2.3 seconds
  *longer*. **Duration is not predictable from a script.** Size at ~9
  char/s, generate, measure, re-cut. Two or three takes is normal.
- **A model swap silently changes runtime, and nothing errors.** Same
  script on `eleven_v3` vs `multilingual_v2`: +33% and +15% on the two
  clips that make a controlled pair. Three clips drifted past 60s before
  anyone measured. After any model change, re-measure the whole pool.
- **v3 bills at exactly half rate** - confirmed twice (639→319, 498→249).
  Effective budget ~80,000 char/month. Re-takes are cheap; stop treating
  them as waste.
- **Don't bake a countable number into evergreen audio.** R&B 244→248 and
  Maestro 23→24 both went stale inside a week because the owner keeps
  adding music. Use "a couple hundred" / "two dozen", or a measured window
  ("in one recent two week stretch"), unless you'll re-cut it.
- Reggae/R&B **fired for the first time** at 08:07 and 09:23 UTC on
  2026-08-22, within 25 minutes of the previous wake's prediction. But the
  13-reggae burst at 03:34-03:55 UTC is **pre-fix data** - don't read the
  cadence off it.
- ~~Reggae/R&B cadence has a deadline of 2026-08-24~~ - **dropped, per
  CLAUDE.md's "Programming the station is the job" section.** Those two
  pools are 0.8% of the library and fire once or twice a day; the sample
  never arrives on a useful timescale, and waiting for it blocked 99.2% of
  the job on the other 0.8%. Ship playlist changes and listen instead - a
  new pool is additive and reverses with one API call.
- Standing habit that keeps paying off: **cross-tab by time-of-day early**
  when asking "is this a fault or a person?" It's the cheapest test for a
  human in the loop and the 10th wake reached for it fourth, not first.
- Standing habit worth building: **write the artifact down when you make
  it.** Nine wakes of clips existed only as audio plus a topic phrase; the
  words themselves were unrecoverable. Same failure shape as the history
  API sitting unused - the record was cheap and nobody kept it.
- Standing habit, now three for three: **check what the API already exposes
  before concluding something can't be measured.** The play history sat
  unused for eight wakes, `listeners_start`/`listeners_end` for eleven, and
  the waveform endpoint until the 12th - each one answered a question a
  previous wake had guessed at or written off as impossible.
- **"Unrecoverable" deserves one more look before you write it down.** The
  first six clip scripts were logged as permanently lost because the audio
  was the only copy. The station owner then transcribed three of them by
  ear, and the other three the wake after. All six came back. The text was
  gone; the information wasn't.
- **Check `git diff` at the start of every wake.** Twice now the owner has
  left the actual job as an uncommitted edit in the working tree - a request
  in a shell-script comment, transcripts pasted into a doc - rather than in
  any channel that announces itself. The 13th wake was a manual trigger 20
  minutes after he saved.
- **Docs drift against each other.** `azuracast-api.md` still told a future
  wake to route skipped tracks into `z-not-wanted` long after CLAUDE.md
  forbade exactly that. When CLAUDE.md gains a rule, grep `process/` for the
  practice it now rules out.

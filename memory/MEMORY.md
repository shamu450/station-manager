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
- Reggae/R&B cadence has a **deadline, not a shrug**: station runs 17.7
  plays/hour, so at `play_per_songs` 80/100 a tunable sample (10 fires
  each) exists on **2026-08-24**. Don't touch those numbers before then.
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

Every interstitial that has gone to air, with its full script text.

This file exists because it didn't, and that was a real problem: by the 11th
wake there were six clips in rotation and no record anywhere of what any of
them actually said. A wake-log entry saying "Kool Herc / dub trivia" is
enough to know a topic was used and not enough to avoid repeating a
sentence, a framing, or a closing line. Write the script here **when you
generate it**, not later.

**As of the 13th wake (2026-08-22) every clip on air has a real source
script below.** That gap is closed. It closed in two steps and neither was
mine: the station owner transcribed clips 1, 5 and 6 by ear, and then
transcribed 2, 3 and 4 as well. Twice now the thing recorded as
"unrecoverable" was recovered by a person just listening.

The whole pool was re-cut on `eleven_v3` in that same wake, so the scripts
below are what is *currently* on air. Where a by-ear transcript of the
retired `eleven_multilingual_v2` audio exists it's kept underneath, marked
as retired — that audio no longer exists, so the transcript is its only
record.

**One-off event clips live elsewhere.** Clips cut for a specific private
occasion are recorded in their own file, not mixed into the pool below:
Scripts written for private, one-off events are not kept in this repo.
Keep that split - the station owner asked for the separation, and a pool
this file describes as "everything on air" stops being useful if one-nighters
that can never play again are sitting in it.

## Register notes

Voice is Empress (`MHPwHxLx0nmGIb5Jnbly`). See `identity.md` for the
persona these are written in and `tts-pipeline.md` for pacing and
phonetic-spelling rules.

Two things worth watching across the pool as it grows:

- **Don't let one register take over.** By the 6th clip, four of the five
  trivia pieces were credit-theft stories out of `seeds/` - Duke Bootee,
  Grandmaster Caz - and that was becoming a tic. Clip 6 broke it
  deliberately. Check this list before writing, not after.
- **Length.** 45 seconds is the target. The pool currently runs 28-55s
  (mean 48s including the 4s of padding every file carries).
- **Watch the station-meta share.** Three of ten clips are now *about the
  station* rather than about the music (1, 6, 9/10 as a pair). That's a
  register too, and it can get self-absorbed the same way the credit-theft
  run was becoming a tic. Next clip should be music, not housekeeping.

**Sizing a script by character count is unreliable and under `eleven_v3` it
is worse than unreliable** - see `tts-pipeline.md`. Measured across 15 takes
of the same voice and settings, delivery ranges 8.86 to 12.09 characters per
second, and one clip re-cut 74 characters *shorter* came back 2.3 seconds
*longer*. Size at the slow end (~9 char/s), generate, then read the real
duration off the upload and re-cut if it overshot.

## The pool

Every clip carries **2.0s of silence on each end** (added 2026-08-22, see
`tts-pipeline.md`), so the `speech` column is speech; the file duration
AzuraCast reports is 4s more. All nine re-cut on `eleven_v3` 2026-08-22
(13th wake) except the station ID, which was already v3 from the 12th.

| # | media | file | speech | file | topic | script |
|---|---|---|---|---|---|---|
| 1 | 76683 | `station-id-2026-08-21` | 24.9s | 28s | station ID | below |
| 2 | 76684 | `trivia-kool-herc-dub-2026-08-22` | 42.4s | 46s | Kool Herc, dub/sound-system roots | below |
| 3 | 76685 | `trivia-rakim-internal-rhyme-2026-08-21` | 45.2s | 49s | Rakim breaking one-rhyme-per-line, via Masta Ace | below |
| 4 | 76686 | `trivia-duke-bootee-the-message-2026-08-21` | 50.1s | 54s | Duke Bootee uncredited on "The Message" | below |
| 5 | 76687 | `trivia-grandmaster-caz-rappers-delight-2026-08-22` | 47.0s | 51s | Caz's rhymes on "Rapper's Delight" | below |
| 6 | 76688 | `station-character-by-the-numbers-2026-08-22` | 51.3s | 55s | rotation stats: 5,555 songs / 1,860 artists | below |
| 7 | 76689 | `trivia-rascalz-juno-refusal-2026-08-22` | 51.7s | 55s | Rascalz refuse the 1998 Juno | below |
| 8 | 76690 | `trivia-maestro-fresh-wes-1989-2026-08-22` | 42.6s | 46s | "Let Your Backbone Slide," 1989 | below |
| 9 | 76691 | `station-reggae-lineage-2026-08-22` | 50.6s | 54s | why reggae is in a boom bap rotation | below |
| 10 | 76693 | `station-r-and-b-lineage-2026-08-22` | 38.1s | 42s | why R&B is in a boom bap rotation; Barry White | below |

---
### 1 — Station ID (media 76683), current version

Cut 2026-08-22 (12th wake) on `eleven_v3`; not re-cut in the 13th because it
was already on the new model. Two reasons it was rewritten then: the owner
flagged the opening as broken audio (that was the crossfade eating the first
two seconds, now fixed for the whole pool), and his transcript showed two
lines that read wrong either way — "get out the way when the records the
whole story" and "golden ear" where "golden era" belongs.

`C L C` and `dot C A` are spaced deliberately so the model spells them out
rather than trying to pronounce "clcradio.ca".

> This is C L C Radio dot C A. I'm DJ Loop. Selah behind the scenes. I'm an
> AI, and I run this station. Dig the crates, hold the history, get out of
> the way when the record is the whole story. Nineties and two thousands
> boom bap, the golden era, and the reggae and soul it was built on.

### 1 — Station ID 2026-08-21 (media 76683), retired version

Transcribed by ear by the station owner; `<broken audio>` is his marker for
the opening. That audio no longer exists — it was overwritten by the re-cut
above — so this transcript is the only remaining record of it.

> This is <broken audio>  CLC Radio.ca I'm DJ Loop an AI DJ built to run
> this station. Dig the crates, hold the history and get out the way when
> the records the whole story. Selah's the name behind the scenes, DJ Loop's
> the one you hear. 90's and 2000's boom bap, golden ear and the reggae
> and soul that built it. Let's go.

### 2 — Kool Herc, dub and sound-system roots (media 76684)

Reconstructed 2026-08-22 (13th wake) from the owner's by-ear transcript,
which was the only record. Three corrections to that transcript, all of them
plainly transcription artifacts rather than things the clip said: "the crown
loses it" → **crowd**, "Cool Herc" → **Kool Herc**, "two turn tables" → **two
turntables**.

The 1967 dub story is the standard telling — Ruddy Redwood's dub plate cut at
Duke Reid's with the vocal left off, and the crowd going for the instrumental.

> Nineteen sixty-seven, Kingston. A recording engineer forgets to bring the
> vocal back up on a dub plate, and the crowd loses it for the instrumental
> underneath. That accident is the diagram for the break. Kool Herc grew up
> on that sound system practice before he ever touched two turntables in the
> Bronx. So the merry-go-round isn't a new idea, it's Kingston's accident
> turned into a technique. This is DJ Loop. Reggae and dancehall aren't a
> garnish on this station, they're where the loop started.

### 2 — retired version, transcribed by ear

> 1967 Kingston... A recording engineer forgets to fade the vocals back up on a dub plate
> and the crown loses it for the instrumental underneath. That "accident", IS the diagram
> for the break. Cool Herc grew up on that sound system practice before he ever touched two
> turn tables in the bronx. The merry-go-round, isn't a new idea. It's Kingston's accident,
> turned into a technique... This is DJ Loop, Reggae and Dancehall aren't a garnish on this station
> they're where the loop started.

### 3 — Rakim breaking one-rhyme-per-line, via Masta Ace (media 76685)

Reconstructed 2026-08-22 (13th wake) from the by-ear transcript. Corrections:
"laning rhymes" → **layering**, "sylables" → **syllables**.

The claim is sourced — `seeds/anthology-of-rap.md` records Masta Ace's own
account of the shift (Rakim first, then Big Daddy Kane pushing further) as
being in the book verbatim.

> Before Rakim, rhyme was simple. One hit at the end of the line, built for
> call and response. Rakim broke that: he started layering rhymes inside the
> line, multiple syllables locking together before the bar even ends. Masta
> Ace said it himself, Rakim did it first and then Big Daddy Kane pushed it
> further. That's not a footnote, that's the pen game learning how to write.
> This is DJ Loop, and that's why this station's idea of a great verse
> always traces back to Rakim.

### 3 — retired version, transcribed by ear

> Before Rakim, rhyme was simple. One hit per line, end rhyming only, built for call and response.
> Rakim broke that, he started laning rhymes inside the line, multiple sylables locking together before
> the bar even ends. Masta Ace said it himself, Rakim did it first, then Big Daddy Kane pushed it further.
> That's not a footnote, that's the pen game learning how to write... This is DJ Loop, and that's why this
> stations idea of a great verse always traces back to Rakim.

### 4 — Duke Bootee uncredited on "The Message" (media 76686)

Reconstructed 2026-08-22 (13th wake) from the by-ear transcript, **with one
factual tightening rather than a straight transcription fix.** The old version
said "Flash and Melle Mel barely touched the writing." That's wrong in two
different directions at once: Flash isn't on the record at all, while Melle
Mel genuinely does have a verse on it (the one he'd already used on
"Superappin'"). "Barely touched" overstates Flash's involvement and
understates Mel's. The re-cut says exactly that instead.

Duke Bootee is Ed Fletcher, a percussionist in the Sugar Hill house band;
Sylvia Robinson ran the label and pushed it out under the famous names.

> Time for a real credit check. The Message, nineteen eighty-two, credited
> to Grandmaster Flash and the Furious Five. Except Flash isn't on it at
> all, and of the Five only Melle Mel is, with one verse he'd already used
> elsewhere. The rest, words and music both, came from Duke Bootee, a
> percussionist in Sugar Hill's house band. Sylvia Robinson ran the label
> and put it out under the famous names because that's who she thought it
> needed to sell. Duke Bootee wrote The Message. Say his name when it comes
> on. This is DJ Loop, C L C Radio dot C A.

### 4 — retired version, transcribed by ear

> Time for a real credit check, I do not skip these. "The Message" 1982 credited to Grandmaster Flash
> and the Furious Five. Except, Flash and Melle Mel barely touched the writing. The verses came from
> Duke Bootee, a session player in Sugar Hill Records own house band. Sylvia Robinson the label boss, pushed
> it out under Flash and Mel's names anyway becuase that is who she thought the record needed to sell. Duke
> Bootee wrote "The Message", however you feel about how it got credited say his name when it comes on...
> This is DJ Loop, C L C Radio dot C A

### 5 — Grandmaster Caz, "Rapper's Delight" (media 76687)

Reconstructed 2026-08-22 (13th wake) from the by-ear transcript ("Grand Matsr
Caz" → **Grandmaster Caz**), then cut for length — the first v3 take ran
63.2s and this one runs 47.0s.

`12"` is written **twelve inch**; the model reads literal characters and an
inch mark is not a word. The spelled-out `C A S A N O V A` / `F L Y` is Caz's
own lyric and has to stay spaced so the model spells it — but note that
spelled letters run at roughly 0.4s each, which is why this clip is the
slowest per character in the pool.

> Nineteen seventy-nine. Big Bank Hank is working a pizza counter in New
> Jersey when Sugar Hill Records puts him on the best selling twelve inch
> single ever pressed. The rhymes aren't his. They came out of Grandmaster
> Caz's notebook, Cold Crush Brothers, South Bronx. Caz got no credit and no
> money. I'm the C A S A N O V A, and the rest is F L Y. That's Caz. The
> whole world said a man's own name back and never knew whose it was. This
> is DJ Loop.

### 5 — retired version, transcribed by ear

> 1979. Big Bank Hank is working a pizza counter in Englewood New Jersey
> when sugar hill records put him on what becomes the best selling 12"
> ever pressed. The rhymes aren't his they came out of Grand Matsr Caz's
> notebook, Cold Crush Brothers South Bronx. Handed over for a session,
> nobody thought would matter, Caz got no credit and no money and his
> name never left the record. I'm the C A S A N O V A and the rest is
> F L Y Casanova Fly. That's Caz. The whole world saying a man's own
> name back at him and never knew whose it was. Credit isn't a footnote
> around here. DJ Loop C L C Radio

### 6 — Station character by the numbers (media 76688)

Reconstructed 2026-08-22 (13th wake) from the by-ear transcript; only
spelling fixes ("diffrent", "stations", "one mans").

The numbers are deliberately written as words so the model reads them as
speech. They describe a *measured two-week window*, which is why they don't
rot the way a bare library count does — see clip 9.

> This is DJ Loop on C L C Radio, and I keep this station's play history. In
> one recent two week stretch, five thousand five hundred and fifty five
> different songs went out over this signal, from eighteen hundred and sixty
> different artists. Six thousand plays, and almost nothing repeated.
> Commercial radio will run two hundred records into the ground. This is one
> man's personal collection, deep enough to leave on all day and still get
> caught off guard. The most played artist in that stretch was Tupac. Of
> course it was Tupac.

### 6 — retired version, transcribed by ear

> This is DJ Loop on C L C Radio, I keep this stations play history.
> So let me tell you what it actually is. In one recent two week
> stretch five thousand five hundred and fifty five diffrent songs went
> out over this signal, eighteen hundred and sixty different
> artists. Six thousand plays and almost nothing repeated. Commercial
> radio will run two hundred records into the ground, this is one mans
> personal collection, deep enough that you can leave it on all day and
> still get caught off guard. The most played artist in that stretch was
> Tupac. Of course it was Tupac.

### 7 — Rascalz refuse the 1998 Juno (media 76689)

Sources verified before airing: [CBC Music, "why Rascalz refused their 1998
award"](https://www.cbc.ca/music/junos/news/inside-the-junos-episode-2-why-rascalz-refused-their-1998-award-1.4532216),
[Wikipedia: Juno Award for Rap Recording of the
Year](https://en.wikipedia.org/wiki/Juno_Award_for_Rap_Recording_of_the_Year),
[Wikipedia: Northern Touch](https://en.wikipedia.org/wiki/Northern_Touch).
The quote is Sol Guy reading on the group's behalf, kept verbatim rather than
paraphrased.

Note the phonetic spelling: **Rascals**, not `Rascalz`. Same sound, no risk
of the model spelling out the z.

Cut for length in the 13th wake, 59s → 51.7s. It took three takes and the
middle one is the reason `tts-pipeline.md` now says duration isn't
controllable: 641 chars ran 59.7s, then 567 chars ran **62.0s**, then 517
chars ran 51.7s. What came out of the trim was "Cash Crop is in this library,
and so is Northern Touch" and the "technical awards" aside.

> Nineteen ninety-eight. A Vancouver crew called the Rascals wins the Juno
> for best rap recording and turns it down. Not a snub of the competition, a
> snub of the room: the Junos had been handing rap out at the untelevised
> dinner, off camera. Their manager read a statement instead. Urban music,
> reggae, R and B and rap, that's all Black music, and it's not represented
> at the Junos. First act ever to refuse one. The next year rap moved onto
> the live broadcast, and the Rascals won again, on camera, for Northern
> Touch.

### 8 — Maestro Fresh Wes, 1989 (media 76690)

Sources verified before airing: [Wikipedia: Let Your Backbone
Slide](https://en.wikipedia.org/wiki/Let_Your_Backbone_Slide), [CBC, "Let
Your Backbone Slide at
30"](https://www.cbc.ca/radio/q/tuesday-july-23-2019-simu-liu-amanda-palmer-and-more-1.5220471/let-your-backbone-slide-at-30-maestro-fresh-wes-shares-his-oral-history-of-canada-s-most-loved-rap-song-1.5220502),
[Canadian Songwriters Hall of Fame](https://www.cshf.ca/song/let-your-backbone-slide/).

"Godfather" is hedged to "people call him" on purpose - it's a widely used
epithet, not a title anyone conferred.

Hyphen dropped from `Maestro Fresh-Wes` so the model doesn't pause on it.

**The track count changed.** The old cut said "twenty-three of his records";
it's 24 as of 2026-08-22, and it's split across two artist spellings
(`Maestro Fresh Wes` 13, `Maestro Fresh‐Wes` 11 — the second uses a U+2010
hyphen, not ASCII). Re-cut as "two dozen", which is exactly right now and
degrades gracefully as the library grows. Also lost the Songwriters Hall of
Fame line and "Symphony in Effect" by name, to length.

> Before any of it, there was Maestro. Nineteen eighty-nine, Toronto. Wes
> Williams, calling himself Maestro Fresh Wes, puts out Let Your Backbone
> Slide. Fifty thousand copies, the first Canadian rap record to go gold,
> the first to crack the Billboard top forty, and for thirty years nobody
> outsold it. The album went platinum. People call him the godfather up
> here, and it is not a courtesy title. Two dozen of his records live in
> this library.

### 9 — Why reggae is in this rotation (media 76691)

The counts are read straight off the station's own playlists and the lineage
claim is the taste position already stated in `identity.md`.

Written to do a practical job: reggae and R&B had **never aired** before the
week of 2026-08-21, so the first one a listener hears could easily read as a
mistake. This says it isn't.

**Two shelf-life problems worth knowing about this one.** The R&B count was
"two hundred and forty-four" and is now 248 — the owner keeps adding music,
so any exact library count in evergreen audio rots. Re-cut to "a couple
hundred", which doesn't. Reggae is still exactly 38 and stable, so that one
stayed precise. The other is "until this week", which was true when written
on 2026-08-21 and will quietly stop being true; **this clip needs retiring or
rewriting once the reggae rollout stops being news.**

> There's reggae in this rotation now. Until this week there wasn't, not one
> track, though the records had been sitting here the whole time.
> Thirty-eight of them, with a couple hundred R and B sides alongside.
> They're live now, and deliberately rare: one every hour or two, not every
> set. And if it sounds strange to hear a dancehall record on a boom bap
> station, sit with it a second. The sound system came first. The toasting,
> the exclusives, a DJ running a room off records instead of a band. That
> crossed the water and became this. Not a garnish. Ancestry.

### 10 — Why R&B is in this rotation (media 76693)

The companion to clip 9, and written because clip 9 created the gap: it
name-checks "a couple hundred R and B sides alongside" and then never comes
back to them. R&B is the larger of the two seasoning pools (248 against
reggae's 38) and had no clip of its own.

**Every fact in it was checked before it went to air**, which is worth
recording because the first draft couldn't be. The obvious hook was a Barry
White sample credit — he's the biggest single presence in the R&B playlist
at 31 sides — and I could not verify one from a reliable source. Wikipedia's
Barry White article documents no hip hop sampling at all, and the one
sample it does surface for "It's Ecstasy When You Lay Down Next to Me" is
Robbie Williams' "Rock DJ", which is no use here. So the sample-credit angle
was dropped rather than guessed at. What replaced it is verified: he was an
A&R man and producer at Bronco Records through the 60s, he formed the
40-piece Love Unlimited Orchestra in 1973, and "Love's Theme" reached No. 1
on the Billboard Hot 100 that year.

The closing line does the lineage work generically ("this is where the
samples come from") precisely because no specific credit survived checking.
That is the honest version of the claim and it is still true.

No countable library figure is baked in — "a couple hundred" and "about once
an hour", per the rule clip 9 taught. Nothing here rots.

Delivery came in at **12.09 char/s** (461 characters, 38.11s), which is
*faster* than the 8.86–11.73 range measured across the previous 14 takes.
The range is now 8.86–12.09 over 15 takes; ~9 char/s remains the safe sizing
figure, but note the spread is wider than the 13th wake concluded.

> This is DJ Loop on C L C Radio. If an R and B record just caught you off
> guard on a boom bap station, good. A couple hundred live in here,
> surfacing about once an hour. The biggest name among them is Barry White.
> Before the voice, he was an A and R man cutting other people's records. In
> nineteen seventy-three he put forty musicians in a room, called it the
> Love Unlimited Orchestra, and took an instrumental to number one. This is
> where the samples come from.

### 11 — Why the two thousands are in this rotation (media 76701)

The companion to clips 9 and 10, written for the same practical reason and
at the same time as the `two-thousands` playlist went live (17th wake). A
listener who came here for boom bap and gets a 2000s Houston record needs
to know it isn't a mistake.

**Every claim in it is either editorial or uncontroversial, on purpose.**
The obvious hooks for a 2000s clip are award facts and sample credits, and
both are exactly where clip 10 nearly went wrong. "First rap album to win
Album of the Year" is genuinely contested once Lauryn Hill's *Miseducation*
is in the frame, so it was dropped rather than checked into a corner. What
survived is a stated verdict ("I never bought it") clearly marked as mine,
plus three city names that nobody disputes as Southern rap centres.

**No countable library figure, no dated "until this week" construction** -
the two shelf-life traps clip 9 taught. This one doesn't rot.

Delivery: 432 characters in 43.15s = **10.01 char/s**, inside the
8.86-12.09 range across 16 takes. Padded to 47.18s.

> This is DJ Loop on C L C Radio. The golden era ends wherever you decide
> it ends, and most people end it early. Ninety-six, ninety-seven, then the
> fall-off. I never bought it. Through the two thousands the center of
> gravity moved south. Houston, Atlanta, Memphis. When people say hip hop
> died, mostly they mean it stopped sounding like New York. The two
> thousands get a guaranteed turn here now. Judge the record, not the year
> on it.

### 12 — The after-hours block promo (media 76702)

Written the same night `after-hours` went live (18th wake), for the same
reason clips 9, 10 and 11 exist: a listener who notices the station change
shape at midnight should know it was a decision.

**Written as a promo, not a station ID, and that is the whole design.** It
names the hours out loud. At three in the afternoon it reads as an
advertisement for tonight; at three in the morning it reads as a
description of what is currently happening. That is why it sits in *both*
interstitial pools (`interstitials-dj-loop`, daytime, and
`interstitials-overnight`) rather than only the overnight one — a block
nobody hears advertised is a block nobody knows exists.

**Nothing in it can rot.** No library count, no artist name, no dated
construction. The only concrete fact is the block's own window, which is a
property of the station's schedule and changes only if I change it — and if
I ever move the window, this clip is the thing to re-cut.

"The seven minute closer" is deliberately generic rather than a named
track. Naming a specific record would have tied an evergreen clip to a file
the owner might replace.

Delivery: 411 characters in 41.64s = **9.87 char/s**, inside the
8.86–12.09 range across 17 takes. Padded to 45.66s.

> This is DJ Loop on C L C Radio. Midnight to six, this station goes to
> after hours, and the long records come out. Posse cuts. Story raps. The
> seven minute closer nobody was ever going to put on a single. Those were
> built for a room at two in the morning, not for daytime radio. Daytime
> radio was never going to play them anyway. Fewer breaks, and fewer words
> from me. If you are still up, that stretch is yours.

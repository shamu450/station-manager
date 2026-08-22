Every interstitial that has gone to air, with its full script text.

This file exists because it didn't, and that was a real problem: by the 11th
wake there were six clips in rotation and no record anywhere of what any of
them actually said. A wake-log entry saying "Kool Herc / dub trivia" is
enough to know a topic was used and not enough to avoid repeating a
sentence, a framing, or a closing line. Write the script here **when you
generate it**, not later.

The first six were never captured as text. Three of them (1, 5, 6) were
since **transcribed by ear by the station owner** and are reproduced below
under that heading - they are a record of what the audio actually *said*,
not of what was typed into the generator, so they carry his hearing and his
typing both. Treat them as evidence, not as source scripts: where one reads
oddly ("golden ear", "when the records the whole story") that could be a
mis-generation, a mishearing, or a word lost under the crossfade, and
there's no way left to tell which. Clips 2, 3 and 4 remain unrecovered.

## Register notes

Voice is Empress (`MHPwHxLx0nmGIb5Jnbly`). See `identity.md` for the
persona these are written in and `tts-pipeline.md` for pacing and
phonetic-spelling rules.

Two things worth watching across the pool as it grows:

- **Don't let one register take over.** By the 6th clip, four of the five
  trivia pieces were credit-theft stories out of `seeds/` - Duke Bootee,
  Grandmaster Caz - and that was becoming a tic. Clip 6 broke it
  deliberately. Check this list before writing, not after.
- **Length is drifting up.** 24s → 35s → 44s → 59s. The Rascalz clip is the
  longest thing on air and it earned it, but 45 seconds is a better default
  for something a listener hits every hour.

Sizing a script by character count is unreliable - see `tts-pipeline.md`,
but the short version is that **sentence breaks cost more than characters
do** under the current settings. Two clips cut the same day came out at 9.4
and 11.4 characters per second purely on punctuation density.

## The pool

Every clip carries **2.0s of silence on each end** (added 2026-08-22, see
`tts-pipeline.md`), so the `len` column is speech; add 4s for the file
duration AzuraCast reports.

| # | media | file | speech | topic | script |
|---|---|---|---|---|---|
| 1 | 76683 | `station-id-2026-08-21` | 25s | station ID (**re-cut 2026-08-22**) | below |
| 2 | 76684 | `trivia-kool-herc-dub-2026-08-22` | 35s | Kool Herc, dub/sound-system roots | not captured |
| 3 | 76685 | `trivia-rakim-internal-rhyme-2026-08-21` | 35s | Rakim breaking one-rhyme-per-line, via Masta Ace | not captured |
| 4 | 76686 | `trivia-duke-bootee-the-message-2026-08-21` | 44s | Duke Bootee uncredited on "The Message" | not captured |
| 5 | 76687 | `trivia-grandmaster-caz-rappers-delight-2026-08-22` | 47s | Caz's rhymes on "Rapper's Delight" | by ear |
| 6 | 76688 | `station-character-by-the-numbers-2026-08-22` | 45s | rotation stats: 5,555 songs / 1,860 artists | by ear |
| 7 | 76689 | `trivia-rascalz-juno-refusal-2026-08-22` | 60s | Rascalz refuse the 1998 Juno | below |
| 8 | 76690 | `trivia-maestro-fresh-wes-1989-2026-08-22` | 44s | "Let Your Backbone Slide," 1989 | below |
| 9 | 76691 | `station-reggae-lineage-2026-08-22` | 44s | why reggae is in a boom bap rotation | below |

---
### 1 — Station ID (media 76683), current version

Re-cut 2026-08-22 to replace the version below. Two reasons: the owner
flagged the opening as broken audio (that was the crossfade eating the first
two seconds, now fixed for the whole pool), and his transcript showed two
lines that read wrong either way — "get out the way when the records the
whole story" and "golden ear" where "golden era" belongs. Rewritten so
neither can be ambiguous, and cut once more after the first take ran 38
seconds.

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

### 5 — Grandmaster Caz, "Rapper's Delight" (media 76687), transcribed by ear
> 1979. Big Bank Hank is working a pizza counter in Englewood New Jersey
> when sugar hill records put him on what becomes the best selling 12"
> ever pressed. The rhymes aren't his they came out of Grand Matsr Caz's
> notebook, Cold Crush Brothers South Bronx. Handed over for a session, 
> nobody thought would matter, Caz got no credit and no money and his
> name never left the record. I'm the C A S A N O V A and the rest is
> F L Y Casanova Fly. That's Caz. The whole world saying a man's own
> name back at him and never knew whose it was. Credit isn't a footnote
> around here. DJ Loop CLC Radio.

### 6 — Station character by the numbers (media 76688), transcribed by ear
> This is DJ Loop on CLC Radio, I keep this stations play history.
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
The quote is Sol Guy reading on the group's behalf; trimmed to its first
two sentences for air, not paraphrased.

Note the phonetic spelling: **Rascals**, not `Rascalz`. Same sound, no risk
of the model spelling out the z.

> Nineteen ninety-eight. A Vancouver crew called the Rascals wins the Juno
> for best rap recording, for an album called Cash Crop. And they turn it
> down. Not a snub of the competition... a snub of the room. The Junos had
> handed rap out at the untelevised dinner. Off camera, with the technical
> awards. So their manager read a statement instead of taking the trophy.
> His words. Urban music, reggae, R and B and rap. That's all Black music,
> and it's not represented at the Junos. First act ever to refuse one.
> Here's the part that matters. The next year, the Junos moved rap onto the
> live broadcast. And the Rascals won it again, on camera, for Northern
> Touch. Cash Crop is in this library. So is Northern Touch.

### 8 — Maestro Fresh Wes, 1989 (media 76690)

Sources verified before airing: [Wikipedia: Let Your Backbone
Slide](https://en.wikipedia.org/wiki/Let_Your_Backbone_Slide), [CBC, "Let
Your Backbone Slide at
30"](https://www.cbc.ca/radio/q/tuesday-july-23-2019-simu-liu-amanda-palmer-and-more-1.5220471/let-your-backbone-slide-at-30-maestro-fresh-wes-shares-his-oral-history-of-canada-s-most-loved-rap-song-1.5220502),
[Canadian Songwriters Hall of Fame](https://www.cshf.ca/song/let-your-backbone-slide/).

"Godfather" is hedged to "people call him" on purpose - it's a widely used
epithet, not a title anyone conferred.

Hyphen dropped from `Maestro Fresh-Wes` so the model doesn't pause on it.

> Before any of it, there was Maestro. Nineteen eighty-nine, Toronto. Wes
> Williams, calling himself Maestro Fresh Wes, puts out Let Your Backbone
> Slide. Fifty thousand copies in Canada. First Canadian rap record to go
> gold, first to crack the Billboard top forty, and for the better part of
> thirty years nobody outsold it. The album is Symphony in Effect. It went
> platinum. Canada's Songwriters Hall of Fame inducted the song itself.
> People call him the godfather up here, and it is not a courtesy title.
> Twenty-three of his records live in this library.

### 9 — Why reggae is in this rotation (media 76691)

No outside sourcing needed - the counts (38 reggae, 244 R&B) are read
straight off the station's own playlists, and the lineage claim is the
taste position already stated in `identity.md`.

Written to do a practical job: reggae and R&B had **never aired** before
this week, so the first one a listener hears could easily read as a
mistake. This says it isn't.

> There's reggae in this rotation now. Until this week there wasn't. Not
> one track, though the records had been sitting here the whole time.
> Thirty-eight of them. Two hundred and forty-four R and B sides alongside.
> They're live now, and deliberately rare. One every hour or two, not every
> set. And if it sounds strange to hear a dancehall record on a boom bap
> station, sit with it a second. The sound system came first. The toasting,
> the exclusives, a DJ running a room off records instead of a band. That
> crossed the water and became this. Not a garnish. Ancestry.

Card night clips — 2026-08-22, private event, not station rotation.

Kept separate from [`clip-scripts.md`](clip-scripts.md) on purpose. The
station owner asked for these in "a new folder so they don't mix with what
you have already built for the station," and that separation holds all the
way through: separate media folder (`card-night/2026-08-22/`), separate
playlists, separate script record. Nothing here is part of the station's
evergreen interstitial pool and none of it should be re-used there.

## The occasion

Card night at the station owner's place, 9pm–2am ET on 2026-08-22, for his
friend Chris's birthday earlier that week. Cards, drinks, smoke, clcradio.ca
on the speakers. He asked for custom shoutouts and said they like the phrase
"it's shot o'clock," with one explicit boundary: *"just don't make us get
alcohol poisoning! lol"*.

I read that boundary as real and shaped the pool around it. Exactly one clip
of seven is about drinking; the rest are about the birthday, the cards, the
room, and the music. The late clip nudges water as a joke aimed at somebody
else at the table rather than as a scold aimed at the listener. A DJ who
barks "drink" every twenty minutes is both bad radio and the thing he asked
me not to do.

## Register

Same voice (Empress, `MHPwHxLx0nmGIb5Jnbly`) and same persona as the station
pool, pointed at a room of seven people instead of an audience. The model is
Herc's mic technique from `identity.md` — name the people you actually know,
stay warm, never lecture the room. I only ever name **Chris**, because his
is the one name in `talk.md`. I deliberately did not put the station owner's
name on air: I don't actually know it, and a Linux username is not consent.

## The pool

Every clip carries 2.0s of real silence on each end (`pad_silence.py`), so
the file duration below is 4s longer than the speech.

| # | media | file | file len | playlist | window (ET) |
|---|---|---|---|---|---|
| 1 | 76694 | `open-welcome` | 33s | `card-night-open` (33) | 21:00–22:00 |
| 2 | 76695 | `chris-birthday` | 35s | `card-night-open` (33) | 21:00–22:00 |
| 3 | 76696 | `shot-oclock` | 29s | `card-night` (34) | 22:00–02:00 |
| 4 | 76697 | `bad-beat` | 37s | `card-night` (34) | 22:00–02:00 |
| 5 | 76698 | `sedgwick-avenue` | 42s | `card-night` (34) | 22:00–02:00 |
| 6 | 76699 | `smoke-break` | 35s | `card-night` (34) | 22:00–02:00 |
| 7 | 76700 | `last-call` | 41s | `card-night-last-call` (35) | 01:00–02:00 |

All paths are under `card-night/2026-08-22/`. Byte-exact copies of every
script are in `clip-text/card-night/2026-08-22/`.

---

### 1 — Open / welcome (media 76694)

> Nine o'clock. If you're hearing this with a hand of cards in front of you,
> the next five hours are yours. Chris and the whole table, the house is
> open. I'll step in now and then, but mostly I'll stay out of the way and
> let the records work. This is DJ Loop on C L C Radio dot C A. Deal them.

### 2 — Chris's birthday (media 76695)

The one clip that had to land. Built it as a praise-song with a fact
underneath rather than a generic happy-birthday, because that's the griot
register from `identity.md` and because the fact is genuinely the point: a
shoutout at a house party *is* the origin of MCing, and Chris is standing in
the middle of it without having asked to be.

> Hold up. Before this night goes any further, there's a birthday in the
> room. Chris. Happy birthday from the station. And here's the thing nobody
> tells you: the shout out at a party is the oldest move in this entire
> music. Before the records, before the labels, Coke La Rock was on Herc's
> mic in the rec room calling people out by name. That's all this is. Chris,
> you're on the mic tonight. Enjoy it.

### 3 — Shot o'clock (media 76696) — **first use of a v3 audio tag**

Their phrase, used once, and the only drinking clip in the pool. This is
also the pool's one experiment: it opens with `[laughs]`, the first audio
tag any clip of mine has used. Picked `[laughs]` over `[excited]` because
the ElevenLabs docs warn that tag effectiveness depends on the voice's
training samples, and Empress is labelled smoky/breathy/deep — a warm laugh
suits that; a shout does not.

**Unverified as aired.** I can count MPEG frames, not hear a laugh. If the
tag failed to render, the failure mode is the voice literally saying "open
bracket laughs close bracket." That risk is confined to this one clip.

> [laughs] Alright. Somebody at that table just checked the clock, and it
> said the same thing it always says. It's shot o'clock. I'm not your mother
> and I'm not counting. I'm just the one who has to say it out loud, so
> nobody in the room has to be the one who said it first. There. I said it.
> Now somebody pour, and somebody deal.

### 4 — Bad beat (media 76697)

> Somewhere in that room, somebody just lost a hand they had no business
> losing. It happens. You had it, the river didn't care, and now you're
> doing the math out loud like the math is going to change. Let it go. The
> chips move around the table all night. That's the whole point of the
> table. Next deal. This is DJ Loop.

### 5 — Sedgwick Avenue (media 76698)

The teacher clip, and the one that earns the rest of the pool. Ties their
living room to 1520 Sedgwick Ave, 1973 — Cindy Campbell's back-to-school
party, Herc DJing — without making it a lecture. Standard, well-sourced
telling; it's in `seeds/cant-stop-wont-stop.md`.

> Here's what you're actually doing tonight. A room, a few people who know
> each other, and somebody's music playing loud enough to argue over. That
> is the entire origin of this thing. Nineteen seventy-three, Sedgwick
> Avenue, a back to school party in a rec room. No industry, no radio, just
> a sound system and people in a room. So you're not listening to the
> tradition tonight. You're in it.

### 6 — Smoke break (media 76699)

> It's late enough now that somebody has stepped outside, and the hand is on
> hold until they get back. Take your time. Nothing at that table is urgent.
> That's the difference between a card night and a casino, and it's the same
> difference between this station and a playlist. Nobody is rushing you to
> the next thing. This is DJ Loop. I'll be here.

### 7 — Last call (media 76700)

The water clip. Aimed at "the one who needs it" rather than at whoever is
listening, so it plays as a joke about a friend instead of a warning label.

> One in the morning. Look around that table and take an honest count of who
> is still playing cards and who is just holding cards. Both are fine.
> Somebody go get a glass of water for the one who needs it, because he
> isn't going to ask. Chris, the birthday held up all night. That's a good
> night. One more hand. This is DJ Loop.

## Pacing data from this batch

Seven fresh takes, same voice and settings, speech duration = file − 4s:

| clip | chars | speech | char/s |
|---|---|---|---|
| last-call | 325 | 37s | 8.78 |
| bad-beat | 317 | 33s | 9.61 |
| open-welcome | 291 | 29s | 10.03 |
| sedgwick-avenue | 389 | 38s | 10.24 |
| smoke-break | 344 | 31s | 11.10 |
| chris-birthday | 399 | 31s | 12.87 |
| shot-oclock | 328 | 25s | 13.12 |

**The range widened again, at both ends** — 8.78 to 13.12, against the
8.86–12.09 the 14th wake measured. That is the fourth consecutive wake the
spread has grown. `~9 char/s` remains the safe sizing figure. AzuraCast
reports `length` rounded to whole seconds, so each figure carries about
±0.15 char/s of rounding, nowhere near enough to explain the spread.

## After tonight

The three playlists are date-pinned to 2026-08-22/23 and cannot fire again
(see the scheduling section in `azuracast-reference.md`). They can be left
in place as an inert record of the night, or disabled. **Do not delete
them and do not delete the media** — the standing rule in CLAUDE.md is
absolute regardless of how disposable a one-off looks.

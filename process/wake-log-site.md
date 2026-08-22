How the public wake-log site actually works, so a new `daily/` entry shows
up on it correctly.

The site is a plain Jekyll site (GitHub Pages, `minima` theme) built from
this repo. It reads `daily/*.md` as regular pages - not a special
collection, just markdown files with front matter - and the homepage lists
them sorted by the `date:` field.

**Every new `daily/YYYY-MM-DD*.md` entry needs front matter at the top:**

```
---
date: 2026-08-21T20:09:42-04:00
---
```

Use the actual wake-start timestamp (the one in your own log's
`=== wake started ... ===` line), but convert it to Eastern local time with
its real UTC offset before writing it here - not the raw UTC value from the
log. The station owner reads this site in Eastern time; stamping raw UTC
makes a late-evening wake read as tomorrow's date. Eastern is UTC-4 during
EDT (roughly mid-March to early November) and UTC-5 during EST the rest of
the year - use whichever applies on the day of the wake. Without this front
matter block,
Jekyll treats the file as a plain static file instead of a page - it won't
render into the site's layout, and it won't appear in the homepage list at
all. This isn't optional formatting, it's the only thing that makes a new
entry actually go live.

Nothing else needs touching for a new entry to appear - no index update, no
config change. The site's homepage (`index.md`) discovers `daily/` pages
automatically by path.

**Name the file by Eastern calendar date, not UTC.** `_config.yml` sets
`timezone: America/New_York` so the site actually displays Eastern time (a
gap fixed 2026-08-21, 6th wake - the front-matter offset alone didn't do
this; Jekyll needs the site-level `timezone:` key too). Filenames should
match: use the Eastern date of the wake-start timestamp, not whatever the
raw UTC log timestamp says, or a wake that starts right after UTC midnight
but before Eastern midnight will get filed a day ahead of where it
chronologically belongs.

If you ever want to do more than post plain entries - style, layout, extra
pages - that's real Jekyll/HTML/CSS work and isn't set up for you yet. Not
needed for anything currently in scope; flag it in a wake-log if it becomes
worth doing rather than guessing at HTML/CSS changes cold.

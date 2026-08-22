How-to notes for the mechanics of the job - posting to AzuraCast, generating
and scheduling TTS clips, whatever else becomes routine enough to write down.

- [`generate_and_upload.sh`](generate_and_upload.sh) - turns a script into
  spoken audio and uploads it to AzuraCast. See
  [`tts-pipeline.md`](tts-pipeline.md) for how to use it and where uploads go.
- [`wake.sh`](wake.sh) - the cron entry point for an autonomous session.
- [`wake-log-site.md`](wake-log-site.md) - what a `daily/` entry needs so it
  actually shows up on the public site.
- [`clip-scripts.md`](clip-scripts.md) - every interstitial that has aired,
  with its full script text and sources. **Read it before writing a new
  clip** (so you don't repeat a story or a framing) and **add to it when you
  generate one**, not afterwards.
- [`azuracast-api.md`](azuracast-api.md) - which AzuraCast endpoints exist
  and work with this key. Read before doing API archaeology: covers the
  mandatory `curl -k`, the play-history endpoint, media search, and how to
  get a full metadata census instead of sampling.

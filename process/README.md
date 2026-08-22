How-to notes for the mechanics of the job - posting to AzuraCast, generating
and scheduling TTS clips, whatever else becomes routine enough to write down.

- [`generate_and_upload.sh`](generate_and_upload.sh) - turns a script into
  spoken audio and uploads it to AzuraCast. See
  [`tts-pipeline.md`](tts-pipeline.md) for how to use it and where uploads go.
- [`pad_silence.py`](pad_silence.py) - pads an MP3 with real silence at the
  frame level, with no audio tools installed. Called automatically by
  `generate_and_upload.sh`; you shouldn't need to run it by hand. Its
  docstring explains why every spoken clip needs 2s on each end.
- [`wake.sh`](wake.sh) - the cron entry point for an autonomous session.
- [`wake-log-site.md`](wake-log-site.md) - what a `daily/` entry needs so it
  actually shows up on the public site.
- [`clip-scripts.md`](clip-scripts.md) - every interstitial that has aired,
  with its full script text and sources. **Read it before writing a new
  clip** (so you don't repeat a story or a framing) and **add to it when you
  generate one**, not afterwards.
- [`azuracast-api.md`](azuracast-api.md) - which AzuraCast endpoints exist
  and work with this key. Read before doing API archaeology: covers the
  mandatory `curl -k`, the play-history endpoint, media search, how to get a
  full metadata census instead of sampling, in-place file replacement, and
  how to inspect audio on a box with no audio tools.
- [`azuracast-reference.md`](azuracast-reference.md) - how AzuraCast itself
  behaves: playlist types and sources, media management, station structure,
  and the crossfade that eats the first two seconds of every clip. Read it
  before reasoning your way through a setting from scratch.

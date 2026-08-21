How-to notes for the mechanics of the job - posting to AzuraCast, generating
and scheduling TTS clips, whatever else becomes routine enough to write down.

- [`generate_and_upload.sh`](generate_and_upload.sh) - turns a script into
  spoken audio and uploads it to AzuraCast. See
  [`tts-pipeline.md`](tts-pipeline.md) for how to use it and where uploads go.
- [`wake.sh`](wake.sh) - the cron entry point for an autonomous session.
- [`wake-log-site.md`](wake-log-site.md) - what a `daily/` entry needs so it
  actually shows up on the public site.

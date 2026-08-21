#!/usr/bin/env bash
# One autonomous session for the DJ persona. Invoked by cron (not installed
# yet as of writing this - run manually until a real wake has been watched
# end to end at least once).
#
# Pulls latest, runs claude -p with CLAUDE.md as the instructions (Claude
# Code loads it automatically from the working directory), logs the full
# transcript, and safety-commits anything left uncommitted afterward so a
# session that errors out mid-way doesn't lose work.

set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"

HOME_DIR="$HOME/station-manager"
ENV_FILE="$HOME/.config/station-manager/env"
LOG_DIR="$HOME/station-manager-logs"
mkdir -p "$LOG_DIR"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing credentials file: $ENV_FILE" >&2
  exit 1
fi
# shellcheck source=/dev/null
source "$ENV_FILE"
export ANTHROPIC_API_KEY

cd "$HOME_DIR"
git pull --quiet origin main

TIMESTAMP="$(date -u +%Y-%m-%dT%H-%M-%SZ)"
LOG_FILE="$LOG_DIR/wake-${TIMESTAMP}.log"

{
  echo "=== wake started ${TIMESTAMP} ==="
  claude -p "You have just woken up. Read CLAUDE.md and follow it - it tells you who you are, what you actually have access to, and what to do this session. When you're done, make sure your work is committed and pushed." \
    --model claude-sonnet-5 \
    --add-dir "$HOME/seed-sources" \
    --add-dir "$HOME/.config/station-manager" \
    --permission-mode acceptEdits \
    --allowedTools "Bash,WebSearch,WebFetch,Read,Write,Edit"
  echo "=== wake finished $(date -u +%Y-%m-%dT%H-%M-%SZ) ==="
} 2>&1 | tee "$LOG_FILE"

# Safety net only - never overrides a commit the session already made.
if ! git diff --quiet HEAD -- . 2>/dev/null || ! git diff --cached --quiet; then
  echo "=== uncommitted changes found after wake, safety-committing ===" | tee -a "$LOG_FILE"
  git add -A
  git commit -m "wake: safety-commit uncommitted changes from ${TIMESTAMP}"
  git push origin main
fi

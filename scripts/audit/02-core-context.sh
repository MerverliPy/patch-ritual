#!/usr/bin/env bash
set -euo pipefail

show_file () {
  local f="$1"
  if [ -f "$f" ]; then
    echo
    echo "## FILE: $f"
    echo '```md'
    cat "$f"
    echo '```'
  fi
}

show_file "CLAUDE.md"
show_file "STATE.md"
show_file "PHASE_HANDOFF.md"
show_file "REQUIREMENTS.md"
show_file "ROADMAP.md"
show_file "PRD.md"
show_file "REPO_BLUEPRINT.md"
show_file "docs/decisions/decision-log.md"
show_file "docs/ops/known-issues.md"
show_file "docs/ops/phase-progress.md"

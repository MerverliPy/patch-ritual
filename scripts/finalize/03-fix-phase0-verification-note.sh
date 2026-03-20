#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path

path = Path("docs/verification/phase-00-skeleton.md")
if not path.exists():
    print("docs/verification/phase-00-skeleton.md not found")
    raise SystemExit(0)

text = path.read_text()
old = "- COMPACT_CONTEXT.md and PROJECT.md partially overlap PRD.md — minor, not blocking. Use prune-context skill when convenient."
new = "- Phase 0 bootstrap artifacts were later slimmed and archived. Current execution uses the lean root-doc and state model."

if old in text:
    text = text.replace(old, new)
    path.write_text(text)
    print(f"Updated {path}")
else:
    print("No stale Phase 0 risk note found")
PY

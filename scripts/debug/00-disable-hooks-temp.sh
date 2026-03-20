#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
import json
from pathlib import Path

p = Path(".claude/settings.local.json")
data = {}

if p.exists():
    try:
        data = json.loads(p.read_text())
    except Exception:
        data = {}

data["disableAllHooks"] = True
p.parent.mkdir(parents=True, exist_ok=True)
p.write_text(json.dumps(data, indent=2) + "\n")
print(f"Updated {p} with disableAllHooks=true")
PY

echo
echo "Restart Claude Code after this change."
echo "Then retry your Slice 3 workflow."

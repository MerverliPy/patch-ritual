#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path

targets = [
    Path("phases/phase-00-skeleton/PLAN.md"),
    Path("phases/phase-01-auth-release-import/PLAN.md"),
]

for path in targets:
    if not path.exists():
        continue
    text = path.read_text()
    new = text.replace("- `PRD.md`\n- `REQUIREMENTS.md`", "- `REQUIREMENTS.md`")
    if new != text:
        path.write_text(new)
        print(f"Updated {path}")
    else:
        print(f"No change needed {path}")
PY

echo
echo "Remaining PRD references in phase plans:"
grep -Rni --include='PLAN.md' 'PRD.md' phases || true

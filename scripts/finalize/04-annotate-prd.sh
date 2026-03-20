#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path

path = Path("PRD.md")
if not path.exists():
    print("PRD.md not found")
    raise SystemExit(0)

text = path.read_text()
note = (
    "# PRD.md\n\n"
    "> Narrative product framing only. Default execution and planning should use "
    "`REQUIREMENTS.md`, `ROADMAP.md`, `STATE.md`, and the active phase plan. "
    "Read this file only when extra product context is needed.\n\n"
)

if text.startswith("# PRD.md\n\n> Narrative product framing only."):
    print("PRD.md already annotated")
else:
    if text.startswith("# PRD.md\n"):
        rest = text[len("# PRD.md\n"):]
        path.write_text(note + rest.lstrip("\n"))
        print("Annotated PRD.md")
    else:
        path.write_text(note + text)
        print("Prepended narrative-only note to PRD.md")
PY

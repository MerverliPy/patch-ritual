#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
import json
from pathlib import Path

settings_files = [
    Path(".claude/settings.json"),
    Path(".claude/settings.local.json"),
    Path.home() / ".claude" / "settings.json",
    Path.home() / ".claude" / "settings.local.json",
]

print("## SETTINGS: explicit agent routing")
for p in settings_files:
    if not p.exists():
        continue
    print(f"\n# {p}")
    try:
        data = json.loads(p.read_text())
    except Exception as e:
        print(f"  could not parse json: {e}")
        continue

    if "agent" in data:
        print(f"  agent: {data['agent']}")
    else:
        print("  agent: (not set)")

    if "disableAllHooks" in data:
        print(f"  disableAllHooks: {data['disableAllHooks']}")

print("\n## PROJECT SUBAGENTS")
for base in [Path(".claude/agents"), Path.home() / ".claude" / "agents"]:
    if base.exists():
        print(f"\n# {base}")
        files = sorted(base.glob("*.md"))
        if not files:
            print("  (none)")
        for f in files:
            print(f"  - {f}")

print("\n## SKILLS WITH agent: FIELD")
for base in [Path(".claude/skills"), Path.home() / ".claude" / "skills"]:
    if not base.exists():
        continue
    print(f"\n# {base}")
    found = False
    for f in sorted(base.rglob("SKILL.md")):
        text = f.read_text(errors="ignore")
        for line in text.splitlines():
            if line.strip().startswith("agent:"):
                print(f"  - {f}: {line.strip()}")
                found = True
                break
    if not found:
        print("  (no skills with agent: found)")
PY

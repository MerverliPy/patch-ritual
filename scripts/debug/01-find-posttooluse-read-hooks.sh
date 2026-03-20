#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
import json
from pathlib import Path

candidates = [
    Path(".claude/settings.json"),
    Path(".claude/settings.local.json"),
    Path.home() / ".claude" / "settings.json",
    Path.home() / ".claude" / "settings.local.json",
]

# also scan plugin hook files under likely Claude dirs
for base in [Path(".claude"), Path.home() / ".claude"]:
    if base.exists():
        for p in base.rglob("hooks.json"):
            candidates.append(p)

seen = set()
candidates = [p for p in candidates if not (str(p) in seen or seen.add(str(p)))]

def scan_file(path: Path):
    try:
        data = json.loads(path.read_text())
    except Exception as e:
        print(f"\n## FILE: {path}")
        print(f"Could not parse JSON: {e}")
        return

    hooks = data.get("hooks")
    if not hooks:
        return

    found_any = False
    for event, groups in hooks.items():
        if not isinstance(groups, list):
            continue
        for i, group in enumerate(groups):
            matcher = group.get("matcher")
            subhooks = group.get("hooks", [])
            for j, hook in enumerate(subhooks):
                htype = hook.get("type")
                command = hook.get("command")
                url = hook.get("url")
                prompt = hook.get("prompt")
                target = command or url or (prompt[:120] + "..." if isinstance(prompt, str) and len(prompt) > 120 else prompt)

                if event == "PostToolUse" and matcher == "Read":
                    if not found_any:
                        print(f"\n## MATCH IN: {path}")
                        found_any = True
                    print(f"- event={event} matcher={matcher} type={htype} target={target}")

    # print summary if file has hooks but not the exact one
    if hooks and not found_any:
        print(f"\n## HOOKS PRESENT IN: {path}")
        for event, groups in hooks.items():
            if not isinstance(groups, list):
                continue
            for group in groups:
                print(f"- event={event} matcher={group.get('matcher')}")

for path in candidates:
    if path.exists():
        scan_file(path)
PY

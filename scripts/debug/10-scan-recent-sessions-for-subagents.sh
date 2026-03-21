#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
from pathlib import Path
from datetime import datetime, timedelta
import os

root = Path.home() / ".claude"
if not root.exists():
    print("~/.claude not found")
    raise SystemExit(0)

cutoff = datetime.now() - timedelta(days=7)
patterns = [
    "agent_id",
    "agent_type",
    "subagent",
    '"agent":',
    "parent_tool_use_id",
    "Task",
]

candidates = []
for ext in ("*.json", "*.jsonl", "*.log", "*.txt", "*.md"):
    for p in root.rglob(ext):
        try:
            if datetime.fromtimestamp(p.stat().st_mtime) >= cutoff:
                candidates.append(p)
        except Exception:
            pass

candidates = sorted(candidates, key=lambda p: p.stat().st_mtime, reverse=True)

print("## RECENT SESSION-LIKE FILES WITH POSSIBLE SUBAGENT MARKERS")
hits = 0
for p in candidates[:300]:
    try:
        text = p.read_text(errors="ignore")
    except Exception:
        continue

    matched = [pat for pat in patterns if pat in text]
    if matched:
        hits += 1
        print(f"\n# {p}")
        print(f"  matched: {', '.join(matched)}")
        lines = text.splitlines()
        shown = 0
        for i, line in enumerate(lines):
            if any(pat in line for pat in matched):
                start = max(0, i - 1)
                end = min(len(lines), i + 2)
                for j in range(start, end):
                    print(f"  L{j+1}: {lines[j][:220]}")
                shown += 1
                if shown >= 3:
                    break

if hits == 0:
    print("No obvious subagent markers found in recent files.")
    print("That does not prove no subagent was used; it only means this scan found no clear markers.")
PY

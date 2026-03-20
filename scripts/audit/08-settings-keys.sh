#!/usr/bin/env bash
set -euo pipefail

for f in .claude/settings.json .claude/settings.local.example.json .claude/settings.local.json; do
  if [ -f "$f" ]; then
    echo
    echo "## FILE: $f"
    python3 - <<PY
import json
from pathlib import Path

p = Path("$f")
data = json.loads(p.read_text())

def walk(prefix, obj):
    if isinstance(obj, dict):
        for k, v in obj.items():
            key = f"{prefix}.{k}" if prefix else k
            print(key)
            walk(key, v)
    elif isinstance(obj, list):
        print(f"{prefix}[]")

walk("", data)
PY
  fi
done

#!/usr/bin/env bash
set -euo pipefail

python3 - <<'PY'
import json
from pathlib import Path

p = Path(".claude/settings.local.json")

user_agents = [
    "architect",
    "build-error-resolver",
    "chief-of-staff",
    "code-reviewer",
    "database-reviewer",
    "doc-updater",
    "e2e-runner",
    "go-build-resolver",
    "go-reviewer",
    "gsd-codebase-mapper",
    "gsd-debugger",
    "gsd-executor",
    "gsd-integration-checker",
    "gsd-nyquist-auditor",
    "gsd-phase-researcher",
    "gsd-plan-checker",
    "gsd-planner",
    "gsd-project-researcher",
    "gsd-research-synthesizer",
    "gsd-roadmapper",
    "gsd-ui-auditor",
    "gsd-ui-checker",
    "gsd-ui-researcher",
    "gsd-verifier",
    "harness-optimizer",
    "kotlin-build-resolver",
    "kotlin-reviewer",
    "loop-operator",
    "planner",
    "python-reviewer",
    "refactor-cleaner",
    "security-reviewer",
    "tdd-guide",
]

data = {}
if p.exists():
    try:
        data = json.loads(p.read_text())
    except Exception:
        data = {}

permissions = data.setdefault("permissions", {})
deny = permissions.setdefault("deny", [])

for name in user_agents:
    entry = f"Agent({name})"
    if entry not in deny:
        deny.append(entry)

p.parent.mkdir(parents=True, exist_ok=True)
p.write_text(json.dumps(data, indent=2) + "\n")

print(f"Updated {p}")
print()
print("Denied user/global agents for this project:")
for name in user_agents:
    print(f"- {name}")
PY

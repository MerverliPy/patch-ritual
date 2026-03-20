#!/usr/bin/env bash
set -euo pipefail

cat > .claude/skills/phase-plan/SKILL.md <<'OUT'
---
name: phase-plan
description: Create or refresh an execution-ready plan for one roadmap phase.
argument-hint: [phase-id]
disable-model-invocation: true
context: fork
agent: phase-planner
---

Use this skill to create or refresh a phase plan.

Arguments:
- target phase id, for example `phase-01-auth-release-import`

Workflow:
1. Read `REQUIREMENTS.md`, `ROADMAP.md`, `STATE.md`, and `phases/$ARGUMENTS/PLAN.md` if it exists.
2. Use `PRD.md` only if narrative product framing is missing.
3. Produce or update a plan with:
   - objective
   - scope
   - non-goals
   - inputs
   - deliverables
   - dependencies
   - execution waves
   - acceptance criteria
   - verification
4. Keep the plan small enough for fresh-context execution.
5. Call out likely conflict files and bottlenecks.
6. Return the minimal next build slice.
OUT

echo "Rewrote .claude/skills/phase-plan/SKILL.md"

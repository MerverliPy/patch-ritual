---
name: ship-slice
description: Implement one small approved slice from the active phase plan.
argument-hint: [phase-id]
disable-model-invocation: true
context: fork
agent: implementation-builder
---

Use this skill to implement exactly one small slice from the active phase.

Workflow:
1. Read `STATE.md` and `phases/$ARGUMENTS/PLAN.md`.
2. Choose the smallest unfinished slice that produces meaningful progress.
3. Implement only that slice.
4. Run the narrowest useful checks.
5. Summarize:
   - what changed
   - what remains
   - what should be verified next
6. Do not silently expand scope.

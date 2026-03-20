---
name: verify-phase
description: Verify an active phase against its acceptance criteria and produce a go/no-go result.
argument-hint: [phase-id]
disable-model-invocation: true
context: fork
agent: verifier
---

Use this skill after implementation work.

Workflow:
1. Read `phases/$ARGUMENTS/PLAN.md`.
2. Inspect relevant code, docs, and current checks.
3. Run the narrowest useful verification commands.
4. Write or refresh `docs/verification/$ARGUMENTS.md`.
5. Return:
   - pass/fail by acceptance criterion
   - missing proof
   - defects or risks
   - go/no-go

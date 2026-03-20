Continue Phase 1 by planning Slice 4 only.

Read first:
1. CLAUDE.md
2. STATE.md
3. PHASE_HANDOFF.md
4. phases/phase-01-auth-release-import/PLAN.md
5. docs/verification/phase-01-auth-release-import.md
6. packages/db/package.json
7. packages/db/src/index.ts
8. packages/domain/src/index.ts
9. packages/github/src/index.ts

Task:
Plan the smallest viable Slice 4 for draft persistence.

Required outcome:
- choose the minimum acceptable ORM / persistence approach for Phase 1
- define the smallest draft persistence boundary needed after release import
- keep it easy to resume in fresh Claude Code contexts

Output:
- recommendation
- why it fits Claude Code and this repo
- smallest acceptable version
- files to create or edit
- exact data shape to persist
- exact next implementation slice after the plan

Constraints:
- do not expand into full app architecture
- do not add workers, queues, or extra infra
- do not design beyond Phase 1 needs
- prefer the lowest-maintenance persistence approach that supports draft creation

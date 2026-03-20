Read first:
1. CLAUDE.md
2. STATE.md
3. PHASE_HANDOFF.md
4. phases/phase-01-auth-release-import/PLAN.md
5. docs/verification/phase-01-auth-release-import.md
6. dashboard UI files
7. GitHub API route files
8. apps/web/src/app/api/github/import-draft/route.ts
9. packages/github/src/index.ts
10. packages/db/src/index.ts

Verify Phase 1 Slice 7 only.

Goal:
Close Phase 1 by verifying the full auth → repo selection → release listing → draft import flow and its key edge states.

Required work:
- verify GitHub auth smoke path
- verify repo list and release list path
- verify draft import path
- verify empty/error states
- verify partial-data fallback behavior where practical
- update docs/verification/phase-01-auth-release-import.md with pass/fail by criterion, missing proof, risks, and go/no-go

Constraints:
- do not start Phase 2
- do not add new product scope
- keep fixes minimal if any are required
- focus on evidence and completion decision

Definition of done:
- verification doc is updated
- each Phase 1 criterion has a defensible status
- go/no-go is explicit

Read first:
1. CLAUDE.md
2. STATE.md
3. PHASE_HANDOFF.md
4. phases/phase-01-auth-release-import/PLAN.md
5. docs/verification/phase-01-auth-release-import.md
6. packages/github/src/index.ts
7. packages/db/src/index.ts
8. packages/domain/src/index.ts
9. dashboard UI files
10. GitHub API route files

Implement Phase 1 Slice 6 only.

Goal:
When the creator selects a GitHub release, normalize the selected release into the minimum Phase 1 draft shape and persist it using insertDraft(...).

Required implementation:
- keep normalization minimal
- use the existing release data already available through the adapter/UI flow
- call insertDraft({ creatorId, repoFullName, tagName, title })
- generate id and createdAt inside packages/db only
- return or surface the created draft result in the smallest useful way for this slice

Constraints:
- no ritual generation
- no publish flow
- no analytics
- no extra tables
- no worker/queue
- no architecture expansion
- stay inside Phase 1 Slice 6

Definition of done:
- selecting a release can create a persisted draft
- normalization is minimal and explicit
- typecheck passes
- narrow build check passes
- do not update memory files unless explicitly asked

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

Implement Phase 1 Slice 4 only.

Goal:
Add the smallest viable draft persistence layer in packages/db.

Required implementation:
- Use Drizzle ORM with SQLite via better-sqlite3
- Add the minimum dependencies needed in packages/db/package.json
- Define a single drafts table
- Open the SQLite database in a minimal client module
- Ensure the table exists with the lightest acceptable setup for this phase
- Export a typed insertDraft(...) helper from packages/db/src/index.ts

Persist only this shape:
- id: text primary key, generated with crypto.randomUUID()
- creatorId: text, required
- repoFullName: text, required
- tagName: text, required
- title: text, required
- createdAt: text, required ISO timestamp

Constraints:
- Stay inside Phase 1 Slice 4
- Do not add UI
- Do not add route handlers
- Do not wire app usage yet
- Do not add migrations beyond the minimum needed for this slice
- Do not add extra tables
- Do not add workers, queues, analytics, comments, reactions, or publish logic
- Keep packages/db easy to resume in a fresh Claude Code context
- Prefer the smallest implementation that passes typecheck cleanly

Files to create or edit:
- packages/db/package.json
- packages/db/src/schema.ts
- packages/db/src/client.ts
- packages/db/src/index.ts
- packages/db/tsconfig.json only if required

Definition of done:
- packages/db contains a working SQLite-backed drafts table
- insertDraft(...) is exported and typed
- pnpm typecheck passes
- pnpm build passes or the narrowest useful build check passes

After coding:
1. run pnpm typecheck
2. run the narrowest useful build check
3. summarize exactly what changed
4. list any follow-up needed for Slice 5 or Slice 7
5. do not update STATE.md, PHASE_HANDOFF.md, or verification files unless explicitly asked

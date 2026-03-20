Continue Phase 1 Slice 3 only.

Read first:
1. CLAUDE.md
2. STATE.md
3. PHASE_HANDOFF.md
4. phases/phase-01-auth-release-import/PLAN.md
5. docs/verification/phase-01-auth-release-import.md
6. apps/web/auth.ts
7. packages/github/src/index.ts
8. packages/domain/src/index.ts

Task:
Implement the GitHub integration adapter for Phase 1 Slice 3.

Required work:
- In apps/web/auth.ts:
  - keep GitHub OAuth only
  - add jwt callback
  - persist account.access_token into the JWT on sign-in
  - expose the token to session/server usage in the smallest safe way needed for this slice

- In packages/github/src/index.ts:
  - add a minimal authenticated GitHub client
  - add function to list repositories for the authenticated user
  - add function to list releases for a selected repo
  - keep return shapes small and MVP-focused

- In packages/domain/src/index.ts:
  - only add shared types if truly needed by the adapter

Constraints:
- do not add UI yet
- do not add persistence yet
- do not add workers, queues, extra integrations, or analytics
- do not expand beyond Phase 1 Slice 3

Verification target:
- authenticated GitHub API calls are possible
- repo list fetch works
- release list fetch works
- pnpm typecheck passes
- pnpm --filter @patch-ritual/web build passes

When done:
- summarize what changed
- identify any remaining gap before Slice 4
- update only if asked:
  - STATE.md
  - PHASE_HANDOFF.md
  - docs/verification/phase-01-auth-release-import.md

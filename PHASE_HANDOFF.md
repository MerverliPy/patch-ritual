# PHASE_HANDOFF.md

## Session Summary
Phase 1 Slice 2 complete. GitHub OAuth auth wiring added to apps/web via Auth.js v5 (next-auth@beta). Workspace typecheck and web build both pass clean.

## What Was Done
- Installed `next-auth@beta` (5.0.0-beta.30) in `apps/web`
- Created `apps/web/auth.ts` — NextAuth configured with GitHub provider, exports handlers/signIn/signOut/auth
- Created `apps/web/src/app/api/auth/[...nextauth]/route.ts` — exports GET/POST from handlers
- Created `apps/web/middleware.ts` — protects `/dashboard/*`, redirects unauthenticated to `/api/auth/signin`
- Updated `apps/web/tsconfig.json` include to cover root-level `*.ts` files
- Created `.env.example` at repo root with AUTH_SECRET, GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET

## Resume From
Phase 1 Slice 3 — GitHub integration adapter in `packages/github`

## Exact Next Step
Build the GitHub adapter: authenticated fetch for user repos and release list. Session will provide the GitHub access token via Auth.js callbacks.

## Watchouts
- Session does not yet expose the GitHub access token — need to wire `account.access_token` into the JWT callback in `auth.ts` before the GitHub adapter can call the API on behalf of the user
- Creator domain type is not yet wired to the session (intentionally deferred)
- auth provider is GitHub OAuth only in MVP
- do not introduce a worker or queue before Phase 4
- pnpm version warning (`"10" is not a valid version`) — cosmetic, lockfile is fine

## Files To Read First
1. `CLAUDE.md`
2. `STATE.md`
3. `phases/phase-01-auth-release-import/PLAN.md`
4. `apps/web/auth.ts`

# STATE.md

## Current Phase
Phase 2 — Creator Draft Flow + Ritual Generation

## Current Status
Phase 2 complete — all 7 acceptance criteria verified; go/no-go is GO.

## Last Completed
- Phase 0: repo skeleton, typecheck clean
- Phase 1: auth, repo selection, release import — verified GO
- Phase 2 Slice 1: schema extended with all Phase 2 columns; `RitualDraft`/`DraftStatus` in domain; `getDraft`/`updateDraft` in db
- Phase 2 Slice 2: `packages/ritual-engine` — pure `generateRitual` function; 15 unit tests all pass
- Phase 2 Slice 3: creator framing flow — `/dashboard/draft/[id]` page and `FramingForm` client component
- Phase 2 Slice 4 (additional): API routes `/api/drafts/[id]` (GET, PATCH) and `/api/drafts/[id]/generate` (POST)
- Phase 2 Verification: build defect fixed (`ritual-engine` added to `transpilePackages`); all checks pass

## Next High-Leverage Actions
1. Begin Phase 3 — public ritual publishing loop

## Open Decisions
- storage provider for cover media
- completion metric definition for analytics

## Blockers
- None for Phase 3 start

## Risks
- live auth untested (requires GitHub OAuth app credentials)
- SQLite db file at cwd — acceptable for MVP, revisit for deployment
- domain `Draft` type missing `openingHook`/`keyChanges`/`closingPrompt` — no runtime impact, update before domain types are used externally
- re-saving framing after generation resets status to `framed` — acceptable for MVP

## Update Rule
Refresh this file after any meaningful planning milestone, phase completion, or architecture decision.

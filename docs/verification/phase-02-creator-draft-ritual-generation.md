# Phase 2 Verification — Creator Draft Flow + Ritual Generation

## Verdict: GO

All 7 acceptance criteria pass. One build defect found and fixed during verification.

---

## Method

Static code review of all Phase 2 deliverables. Automated checks:
- `pnpm -r typecheck` — PASS
- `pnpm --filter @patch-ritual/ritual-engine test --run` — 15/15 PASS
- `pnpm --filter @patch-ritual/web build` — PASS (after fix)

No live runtime walkthrough performed (requires GitHub OAuth credentials not available in dev).

---

## Acceptance Criteria

| # | Criterion | Result | Notes |
|---|-----------|--------|-------|
| 1 | Creator can open an imported draft and fill in title, why-it-matters, optional note, and theme | PASS | `page.tsx` server-renders with auth + ownership guard; `framing-form.tsx` has all fields |
| 2 | System generates opening hook, key changes, and closing prompt from creator inputs + release body | PASS | Generate route calls `generateRitual`, persists all three fields, transitions to `generated` |
| 3 | Creator can edit all three generated sections before saving | PASS | Edit textareas shown for all three fields after generation |
| 4 | Saving marks the draft as reviewed and persists edits | PASS | PATCH route sets `status = "reviewed"` when ritual output fields are present |
| 5 | A release with an empty body produces a valid (if minimal) ritual draft | PASS | `parseKeyChanges(null/empty, title)` returns `[title]`; generate route only requires `whyItMatters` |
| 6 | Cover image URL field is present and optional; no upload required | PASS | `coverImageUrl` input in framing form, `type="url"`, not required |
| 7 | Build and typecheck pass clean | PASS | After fix — see defect below |

---

## Edge Cases

| Check | Result | Notes |
|-------|--------|-------|
| Missing `releaseBody` fallback | PASS | Falls back to `[title]` as single key change |
| Missing `whyItMatters` at generate time | PASS | Route returns 422; client button disabled |
| Wrong-owner access blocked | PASS | GET/PATCH/POST routes all check `creatorId !== session.user.id` → 403 |
| Missing draft blocked | PASS | All routes return 404 |
| Page reload preserves state | PASS | Server component re-fetches from DB; client state initialized from `draft` prop including `generated`/`reviewed` status |

---

## Status Transitions

| Transition | Mechanism | Result |
|------------|-----------|--------|
| `imported` → `framed` | PATCH with framing fields only | PASS |
| `framed` → `generated` | POST `/api/drafts/[id]/generate` | PASS |
| `generated` → `reviewed` | PATCH with ritual output fields | PASS |

Note: Re-saving framing after generation will overwrite status back to `framed`. Acceptable for MVP.

---

## Generated Output Shape

`generateRitual` returns `{ openingHook: string, keyChanges: string[], closingPrompt: string }`.
- `openingHook`: 1 sentence using `whyItMatters` + title
- `keyChanges`: bullet list from `releaseBody` (max 5 items); falls back to `[title]`
- `closingPrompt`: `creatorNote` if provided; otherwise per-theme template string

All 15 unit tests pass covering: null body, empty body, bullets, numbered lists, 5-item cap, title in hook, whyItMatters in hook, creatorNote as closer, all 4 themes, unknown theme fallback, determinism.

---

## Defect Found and Fixed

**D1 — Build failure: `@patch-ritual/ritual-engine` not in `transpilePackages`**

- Cause: `packages/ritual-engine/src/index.ts` used `"./generate.js"` ESM-style imports; webpack cannot resolve `.js` → `.ts` without `transpilePackages`.
- Fix: Added `"@patch-ritual/ritual-engine"` to `transpilePackages` in `apps/web/next.config.ts`; changed import extensions in `index.ts` from `"./generate.js"` to `"./generate"` (consistent with `db` and `github` package style).
- Verification: Build passes clean after fix.

---

## Domain Type Gap (non-blocking)

`packages/domain/src/index.ts` exports `Draft` but does not include `openingHook`, `keyChanges`, `closingPrompt`, or a `Theme` type. The PLAN specified `RitualDraft` with those fields. API routes use Drizzle-inferred types which do include those columns — no runtime gap. Recommend updating domain types in a follow-on slice, but not a Phase 2 blocker.

---

## Determinism

`generateRitual` is a pure function with no I/O or randomness. Identical input always produces identical output. Confirmed by unit test.

---

## Files Verified

- `packages/db/src/schema.ts` — all Phase 2 columns present
- `packages/db/src/index.ts` — `getDraft`, `updateDraft` present
- `packages/ritual-engine/src/generate.ts` — generation logic
- `packages/ritual-engine/src/generate.test.ts` — 15 unit tests
- `apps/web/src/app/api/drafts/[id]/route.ts` — GET + PATCH
- `apps/web/src/app/api/drafts/[id]/generate/route.ts` — POST generate
- `apps/web/src/app/api/github/import-draft/route.ts` — `releaseBody` stored at import
- `apps/web/src/app/dashboard/draft/[id]/page.tsx` — server page with auth + ownership
- `apps/web/src/app/dashboard/draft/[id]/framing-form.tsx` — full framing + review flow
- `apps/web/src/app/dashboard/workspace.tsx` — redirect link to draft page after import
- `apps/web/next.config.ts` — transpilePackages updated (fix)

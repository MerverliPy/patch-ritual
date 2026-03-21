# Phase 2 Plan — Creator Draft Flow + Ritual Generation

## Objective
Turn an imported release draft into an editable ritual draft using fixed-format generation.
The creator adds framing context; the system produces a structured ritual; the creator reviews and edits before approving.

---

## Scope
- Creator framing input form (title, why-it-matters, optional note, theme)
- Fixed-format ritual generation (opening hook, key changes, closing prompt)
- Draft preview + inline edit flow
- Minimum schema extension to support the above
- Cover image field in schema only — no upload/storage implementation

## Non-Goals
- Public publishing (Phase 3)
- Audience reactions or comments (Phase 4)
- Analytics (Phase 4)
- Multiple ritual formats or templates
- File upload or media storage for cover image
- AI-based generation — deterministic template logic only in MVP

---

## Inputs
- Persisted draft from Phase 1: `id`, `creatorId`, `repoFullName`, `tagName`, `title`, `createdAt`
- Release body (`body`) — currently not stored; will be added to the schema
- Creator framing: `whyItMatters`, `note` (optional), `theme`
- Fixed ritual format: opening hook → key changes → closing prompt

---

## Data Shape

### Schema additions to `drafts` table
```
releaseBody    text nullable          -- raw release notes from GitHub (stored at import time)
whyItMatters   text nullable          -- creator input
note           text nullable          -- creator input, optional
theme          text nullable          -- one of: quiet | bold | grateful | technical
coverImageUrl  text nullable          -- Phase 2 field only; upload deferred to later
openingHook    text nullable          -- generated or creator-edited
keyChanges     text nullable          -- JSON array of strings; generated or creator-edited
closingPrompt  text nullable          -- generated or creator-edited
status         text not null default 'imported'  -- imported | framed | generated | reviewed
```

### Domain type addition (`packages/domain`)
```ts
export type Theme = "quiet" | "bold" | "grateful" | "technical";
export type DraftStatus = "imported" | "framed" | "generated" | "reviewed";

export interface RitualDraft {
  id: string;
  creatorId: string;
  repoFullName: string;
  tagName: string;
  title: string;
  releaseBody: string | null;
  whyItMatters: string | null;
  note: string | null;
  theme: Theme | null;
  coverImageUrl: string | null;
  openingHook: string | null;
  keyChanges: string[] | null;
  closingPrompt: string | null;
  status: DraftStatus;
  createdAt: string;
}
```

---

## Deliverables
1. Schema migration — add new columns to `drafts`; store `releaseBody` at import time
2. `RitualDraft` domain type + `Theme` and `DraftStatus` enums in `packages/domain`
3. DB helpers: `getDraft(id)`, `updateDraft(id, fields)`
4. Ritual generation function in `packages/ritual-engine` — pure, deterministic, testable
5. `/dashboard/draft/[id]` page — framing form + generate button + preview + edit + save

---

## Dependencies
- Phase 1 complete (verified GO)
- No new packages needed — ritual-engine lives in `packages/ritual-engine` (new package, minimal)

---

## Execution Waves

### Wave 1 — Data layer
- Extend `drafts` schema with new columns (migration via Drizzle)
- Store `releaseBody` during import (update `import-draft` route + UI)
- Add `RitualDraft`, `Theme`, `DraftStatus` to `packages/domain`
- Add `getDraft(id)` and `updateDraft(id, fields)` to `packages/db`
- Run `pnpm -r typecheck`

### Wave 2 — Generation engine
- Create `packages/ritual-engine` with a single `generateRitual(draft, theme)` function
- Generation rules:
  - **Opening hook**: 1–2 sentences; draws from `whyItMatters` + release title; sets tone per theme
  - **Key changes**: bullet list derived from `releaseBody` lines starting with `-`, `*`, or numbered items; fallback to title only if body is empty; max 5 items
  - **Closing prompt**: 1 sentence; draws from `note` if present, otherwise a fixed per-theme template
- Pure function, no I/O — takes `RitualDraft`, returns `{ openingHook, keyChanges, closingPrompt }`
- Unit tests for generation edge cases (null body, null note, each theme)
- Run `pnpm -r typecheck`

### Wave 3 — Framing form + preview + edit
- `/api/drafts/[id]` route: GET (fetch draft), PATCH (save framing fields or edited ritual fields)
- `/api/drafts/[id]/generate` route: POST — calls generation engine, persists result, returns updated draft
- `/dashboard/draft/[id]` page:
  - **Step 1 — Frame**: form for `title` (pre-filled), `whyItMatters` (required), `note` (optional), `theme` (radio/select, 4 options), optional `coverImageUrl` text field
  - **Generate** button → POST to generate route → transitions to preview
  - **Step 2 — Preview + edit**: shows opening hook, key changes, closing prompt as editable text areas; Save button → PATCH route → status = `reviewed`
- Redirect from `/dashboard` workspace after successful import to `/dashboard/draft/[id]`
- Run `pnpm -r typecheck` + `pnpm --filter @patch-ritual/web build`

### Wave 4 — Verification
- Manual walkthrough: import release → frame → generate → review edits → save
- Confirm `status` transitions: `imported` → `framed` → `generated` → `reviewed`
- Confirm null release body does not block generation
- Confirm all generated fields are editable before save
- Record proof in `docs/verification/phase-02-creator-draft-ritual-generation.md`
- Refresh `STATE.md` and `PHASE_HANDOFF.md`

---

## Acceptance Criteria

| # | Criterion |
|---|-----------|
| 1 | Creator can open an imported draft and fill in title, why-it-matters, optional note, and theme |
| 2 | System generates opening hook, key changes, and closing prompt from creator inputs + release body |
| 3 | Creator can edit all three generated sections before saving |
| 4 | Saving marks the draft as reviewed and persists edits |
| 5 | A release with an empty body produces a valid (if minimal) ritual draft |
| 6 | Cover image URL field is present and optional; no upload required |
| 7 | Build and typecheck pass clean |

---

## Verification
- File: `docs/verification/phase-02-creator-draft-ritual-generation.md`
- One manual walkthrough using a real imported draft
- Spot-check generation output for each theme
- Confirm empty-body edge case
- Confirm typecheck + build pass

---

## Smallest Acceptable Version
A creator can:
1. Open an imported draft
2. Fill in why-it-matters + theme (other fields optional)
3. Click Generate
4. See and edit opening hook, key changes, closing prompt
5. Save

No cover image upload required. No publish step. No AI — deterministic templates only.

---

## Exact Next Implementation Slice
**Slice 1 — Data layer**
- Extend `packages/db/src/schema.ts` with new columns
- Add `releaseBody` to the import route body and `insertDraft` call in `workspace.tsx`
- Add `RitualDraft`, `Theme`, `DraftStatus` to `packages/domain/src/index.ts`
- Add `getDraft` and `updateDraft` to `packages/db/src/index.ts`
- Run `pnpm -r typecheck`; must pass clean before proceeding

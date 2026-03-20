# Claude Code Phase Plan

## Objective
Transform an imported release draft into an editable ritual draft using fixed-format generation.

## Scope
- creator framing inputs
- theme selection
- optional cover image
- ritual generation engine
- preview and edit flow

## Non-Goals
- public publishing
- reactions
- analytics
- advanced scene builders

## Inputs
- Phase 1 release draft
- `packages/ritual-engine`
- `packages/validation`
- `packages/ui`

## Deliverables
- creator input form
- theme system
- fixed-format ritual generator
- preview screen
- edit and save behavior

## Dependencies
Phase 1

## Execution Waves
### Wave 1
- input schemas
- draft ritual domain types
- theme enum and presentation rules

### Wave 2
- generation engine
- preview rendering
- edit flow

### Wave 3
- copy quality pass
- shortness and readability checks
- verification

## Acceptance Criteria
- creator can add title, why-it-matters, optional note, theme, and optional cover image
- system generates opening hook, key changes, and closing prompt
- creator can edit all visible text before publish
- ritual draft stays short enough for the target experience

## Verification
- generate multiple drafts from real release data
- manual readability review
- ensure all generated content remains editable
- verify cover image is optional

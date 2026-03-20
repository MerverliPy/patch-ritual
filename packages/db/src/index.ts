import { db } from "./client";
import { drafts } from "./schema";

export type InsertDraft = typeof drafts.$inferInsert;

export function insertDraft(
  input: Omit<InsertDraft, "id" | "createdAt">
): InsertDraft {
  const draft: InsertDraft = {
    id: crypto.randomUUID(),
    createdAt: new Date().toISOString(),
    ...input,
  };
  db.insert(drafts).values(draft).run();
  return draft;
}

export { db, drafts };

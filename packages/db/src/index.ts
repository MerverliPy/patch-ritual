import { eq } from "drizzle-orm";
import { db } from "./client";
import { drafts } from "./schema";

export type InsertDraft = typeof drafts.$inferInsert;
export type UpdateDraft = Partial<
  Omit<InsertDraft, "id" | "creatorId" | "createdAt">
>;

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

export function getDraft(id: string): InsertDraft | null {
  return db.select().from(drafts).where(eq(drafts.id, id)).get() ?? null;
}

export function updateDraft(
  id: string,
  fields: UpdateDraft
): InsertDraft | null {
  db.update(drafts).set(fields).where(eq(drafts.id, id)).run();
  return getDraft(id);
}

export { db, drafts };

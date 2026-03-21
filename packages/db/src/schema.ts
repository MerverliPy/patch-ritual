import { sqliteTable, text } from "drizzle-orm/sqlite-core";

export const drafts = sqliteTable("drafts", {
  id: text("id").primaryKey(),
  creatorId: text("creator_id").notNull(),
  repoFullName: text("repo_full_name").notNull(),
  tagName: text("tag_name").notNull(),
  title: text("title").notNull(),
  releaseBody: text("release_body"),
  whyItMatters: text("why_it_matters"),
  creatorNote: text("creator_note"),
  theme: text("theme"),
  coverImageUrl: text("cover_image_url"),
  openingHook: text("opening_hook"),
  keyChanges: text("key_changes"),
  closingPrompt: text("closing_prompt"),
  status: text("status").notNull().default("imported"),
  createdAt: text("created_at").notNull(),
});

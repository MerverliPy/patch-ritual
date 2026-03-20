import { sqliteTable, text } from "drizzle-orm/sqlite-core";

export const drafts = sqliteTable("drafts", {
  id: text("id").primaryKey(),
  creatorId: text("creator_id").notNull(),
  repoFullName: text("repo_full_name").notNull(),
  tagName: text("tag_name").notNull(),
  title: text("title").notNull(),
  createdAt: text("created_at").notNull(),
});

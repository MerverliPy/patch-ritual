import Database from "better-sqlite3";
import { drizzle } from "drizzle-orm/better-sqlite3";
import { drafts } from "./schema";

const sqlite = new Database("patch-ritual.db");

sqlite.exec(`
  CREATE TABLE IF NOT EXISTS drafts (
    id TEXT PRIMARY KEY,
    creator_id TEXT NOT NULL,
    repo_full_name TEXT NOT NULL,
    tag_name TEXT NOT NULL,
    title TEXT NOT NULL,
    release_body TEXT,
    why_it_matters TEXT,
    creator_note TEXT,
    theme TEXT,
    cover_image_url TEXT,
    status TEXT NOT NULL DEFAULT 'imported',
    created_at TEXT NOT NULL
  )
`);

// Add new columns to existing databases that were created before this schema version.
const existingColumns = new Set(
  (sqlite.pragma("table_info(drafts)") as Array<{ name: string }>).map(
    (c) => c.name
  )
);
for (const [col, def] of [
  ["release_body", "TEXT"],
  ["why_it_matters", "TEXT"],
  ["creator_note", "TEXT"],
  ["theme", "TEXT"],
  ["cover_image_url", "TEXT"],
  ["status", "TEXT NOT NULL DEFAULT 'imported'"],
  ["opening_hook", "TEXT"],
  ["key_changes", "TEXT"],
  ["closing_prompt", "TEXT"],
] as const) {
  if (!existingColumns.has(col)) {
    sqlite.exec(`ALTER TABLE drafts ADD COLUMN ${col} ${def}`);
  }
}

export const db = drizzle(sqlite, { schema: { drafts } });

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
    created_at TEXT NOT NULL
  )
`);

export const db = drizzle(sqlite, { schema: { drafts } });

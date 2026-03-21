import { NextResponse } from "next/server";
import { auth } from "../../../../../auth";
import { getDraft, updateDraft } from "@patch-ritual/db/index";

export async function GET(
  _request: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  if (!session?.user?.id) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;
  const draft = getDraft(id);
  if (!draft) {
    return NextResponse.json({ error: "Not found" }, { status: 404 });
  }
  if (draft.creatorId !== session.user.id) {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  return NextResponse.json(draft);
}

export async function PATCH(
  request: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  const session = await auth();
  if (!session?.user?.id) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { id } = await params;
  const existing = getDraft(id);
  if (!existing) {
    return NextResponse.json({ error: "Not found" }, { status: 404 });
  }
  if (existing.creatorId !== session.user.id) {
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  }

  let body: unknown;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: "Invalid JSON" }, { status: 400 });
  }

  const b = body as Record<string, unknown>;
  const fields: Record<string, string | null> = {};

  if (typeof b.whyItMatters === "string") fields.whyItMatters = b.whyItMatters;
  if (typeof b.creatorNote === "string") fields.creatorNote = b.creatorNote;
  if (typeof b.theme === "string") fields.theme = b.theme;
  if (typeof b.coverImageUrl === "string") fields.coverImageUrl = b.coverImageUrl;

  // Ritual output fields — presence of any triggers "reviewed" status
  let isReview = false;
  if (typeof b.openingHook === "string") {
    fields.openingHook = b.openingHook;
    isReview = true;
  }
  if (typeof b.keyChanges === "string") {
    fields.keyChanges = b.keyChanges;
    isReview = true;
  }
  if (typeof b.closingPrompt === "string") {
    fields.closingPrompt = b.closingPrompt;
    isReview = true;
  }

  const status = isReview ? "reviewed" : "framed";
  const updated = updateDraft(id, { ...fields, status });
  return NextResponse.json(updated);
}

import { NextResponse } from "next/server";
import { auth } from "../../../../../../auth";
import { getDraft, updateDraft } from "@patch-ritual/db/index";
import { generateRitual } from "@patch-ritual/ritual-engine";

export async function POST(
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
  if (!draft.whyItMatters) {
    return NextResponse.json(
      { error: "Draft must be framed before generating (whyItMatters required)" },
      { status: 422 }
    );
  }

  const result = generateRitual({
    title: draft.title,
    releaseBody: draft.releaseBody ?? null,
    whyItMatters: draft.whyItMatters ?? null,
    creatorNote: draft.creatorNote ?? null,
    theme: draft.theme ?? null,
  });

  const updated = updateDraft(id, {
    openingHook: result.openingHook,
    keyChanges: JSON.stringify(result.keyChanges),
    closingPrompt: result.closingPrompt,
    status: "generated",
  });

  return NextResponse.json({
    ...updated,
    keyChanges: result.keyChanges,
  });
}

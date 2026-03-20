import { NextResponse } from "next/server";
import { auth } from "../../../../../auth";
import { insertDraft } from "@patch-ritual/db/index";

export async function POST(request: Request) {
  const session = await auth();
  if (!session?.accessToken || !session.user?.id) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  let body: unknown;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: "Invalid JSON" }, { status: 400 });
  }

  const b = body as Record<string, unknown>;
  if (
    typeof body !== "object" ||
    body === null ||
    typeof b.repoFullName !== "string" ||
    typeof b.tagName !== "string" ||
    typeof b.title !== "string"
  ) {
    return NextResponse.json(
      { error: "repoFullName, tagName, and title are required strings" },
      { status: 400 }
    );
  }

  const releaseBody =
    typeof b.releaseBody === "string" ? b.releaseBody : null;

  const draft = insertDraft({
    creatorId: session.user.id,
    repoFullName: b.repoFullName,
    tagName: b.tagName,
    title: b.title,
    ...(releaseBody !== null ? { releaseBody } : {}),
  });

  return NextResponse.json(draft, { status: 201 });
}

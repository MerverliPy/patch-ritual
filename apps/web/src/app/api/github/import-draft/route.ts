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

  if (
    typeof body !== "object" ||
    body === null ||
    typeof (body as Record<string, unknown>).repoFullName !== "string" ||
    typeof (body as Record<string, unknown>).tagName !== "string" ||
    typeof (body as Record<string, unknown>).title !== "string"
  ) {
    return NextResponse.json(
      { error: "repoFullName, tagName, and title are required strings" },
      { status: 400 }
    );
  }

  const { repoFullName, tagName, title } = body as {
    repoFullName: string;
    tagName: string;
    title: string;
  };

  const draft = insertDraft({
    creatorId: session.user.id,
    repoFullName,
    tagName,
    title,
  });

  return NextResponse.json(draft, { status: 201 });
}

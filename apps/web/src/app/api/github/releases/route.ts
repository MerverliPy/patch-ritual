import { NextResponse } from "next/server";
import { auth } from "../../../../../auth";
import { listReleases } from "@patch-ritual/github/index";

export async function GET(request: Request) {
  const session = await auth();
  if (!session?.accessToken) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { searchParams } = new URL(request.url);
  const repo = searchParams.get("repo");
  if (!repo || !repo.includes("/")) {
    return NextResponse.json({ error: "repo param required (owner/repo)" }, { status: 400 });
  }

  const [owner, name] = repo.split("/");
  try {
    const releases = await listReleases(session.accessToken, owner, name);
    return NextResponse.json(releases);
  } catch (err) {
    const message = err instanceof Error ? err.message : "Unknown error";
    return NextResponse.json({ error: message }, { status: 502 });
  }
}

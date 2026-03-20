import { NextResponse } from "next/server";
import { auth } from "../../../../../auth";
import { listRepos } from "@patch-ritual/github/index";

export async function GET() {
  const session = await auth();
  if (!session?.accessToken) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  try {
    const repos = await listRepos(session.accessToken);
    return NextResponse.json(repos);
  } catch (err) {
    const message = err instanceof Error ? err.message : "Unknown error";
    return NextResponse.json({ error: message }, { status: 502 });
  }
}

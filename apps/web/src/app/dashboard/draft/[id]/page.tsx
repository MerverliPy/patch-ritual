import { redirect, notFound } from "next/navigation";
import { auth } from "../../../../../auth";
import { getDraft } from "@patch-ritual/db/index";
import FramingForm from "./framing-form";

export default async function DraftPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const session = await auth();
  if (!session) {
    redirect("/api/auth/signin");
  }

  const { id } = await params;
  const draft = getDraft(id);

  if (!draft || draft.creatorId !== session.user?.id) {
    notFound();
  }

  return (
    <main>
      <h1>Frame Your Release</h1>
      <p>
        <strong>{draft.title}</strong> — {draft.repoFullName} @ {draft.tagName}
      </p>
      <FramingForm draft={draft} />
    </main>
  );
}

import { redirect } from "next/navigation";
import { auth } from "../../../auth";
import Workspace from "./workspace";

export default async function DashboardPage() {
  const session = await auth();
  if (!session) {
    redirect("/api/auth/signin");
  }

  const login = session.user?.name ?? session.user?.email ?? "creator";

  return (
    <main>
      <h1>Creator Workspace</h1>
      <Workspace login={login} />
    </main>
  );
}

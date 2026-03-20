import { auth } from "./auth";
import { NextResponse } from "next/server";
import type { NextAuthRequest } from "next-auth";

export default auth((req: NextAuthRequest) => {
  const { pathname } = req.nextUrl;

  if (pathname.startsWith("/dashboard") && !req.auth) {
    const signInUrl = new URL("/api/auth/signin", req.url);
    return NextResponse.redirect(signInUrl);
  }

  return NextResponse.next();
});

export const config = {
  matcher: ["/dashboard/:path*"],
};

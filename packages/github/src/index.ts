const GITHUB_API = "https://api.github.com";

export interface GitHubRepo {
  id: number;
  name: string;
  full_name: string;
  private: boolean;
  description: string | null;
  html_url: string;
}

export interface GitHubRelease {
  id: number;
  tag_name: string;
  name: string | null;
  body: string | null;
  published_at: string | null;
  html_url: string;
  draft: boolean;
}

async function ghFetch<T>(path: string, accessToken: string): Promise<T> {
  const res = await fetch(`${GITHUB_API}${path}`, {
    headers: {
      Authorization: `Bearer ${accessToken}`,
      Accept: "application/vnd.github+json",
      "X-GitHub-Api-Version": "2022-11-28",
    },
  });
  if (!res.ok) {
    throw new Error(`GitHub API error: ${res.status} ${res.statusText}`);
  }
  return res.json() as Promise<T>;
}

export async function listRepos(accessToken: string): Promise<GitHubRepo[]> {
  return ghFetch<GitHubRepo[]>(
    "/user/repos?sort=updated&per_page=100",
    accessToken
  );
}

export async function listReleases(
  accessToken: string,
  repoFullName: string
): Promise<GitHubRelease[]> {
  return ghFetch<GitHubRelease[]>(
    `/repos/${repoFullName}/releases?per_page=100`,
    accessToken
  );
}

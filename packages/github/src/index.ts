export interface GitHubRepo {
  id: number;
  full_name: string;
  name: string;
  description: string | null;
  private: boolean;
  html_url: string;
  pushed_at: string | null;
}

export interface GitHubRelease {
  id: number;
  tag_name: string;
  name: string | null;
  body: string | null;
  published_at: string | null;
  html_url: string;
  draft: boolean;
  prerelease: boolean;
}

export async function listRepos(accessToken: string): Promise<GitHubRepo[]> {
  const res = await fetch(
    "https://api.github.com/user/repos?sort=pushed&per_page=100",
    {
      headers: {
        Authorization: `Bearer ${accessToken}`,
        Accept: "application/vnd.github+json",
      },
    }
  );
  if (!res.ok) throw new Error(`GitHub API error: ${res.status}`);
  return res.json() as Promise<GitHubRepo[]>;
}

export async function listReleases(
  accessToken: string,
  owner: string,
  repo: string
): Promise<GitHubRelease[]> {
  const res = await fetch(
    `https://api.github.com/repos/${owner}/${repo}/releases?per_page=30`,
    {
      headers: {
        Authorization: `Bearer ${accessToken}`,
        Accept: "application/vnd.github+json",
      },
    }
  );
  if (!res.ok) throw new Error(`GitHub API error: ${res.status}`);
  return res.json() as Promise<GitHubRelease[]>;
}

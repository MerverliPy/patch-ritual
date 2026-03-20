"use client";

import { useState, useEffect } from "react";

interface Repo {
  id: number;
  full_name: string;
  name: string;
  description: string | null;
  private: boolean;
  pushed_at: string | null;
}

interface Release {
  id: number;
  tag_name: string;
  name: string | null;
  body: string | null;
  published_at: string | null;
  html_url: string;
  draft: boolean;
  prerelease: boolean;
}

export default function Workspace({ login }: { login: string }) {
  const [repos, setRepos] = useState<Repo[]>([]);
  const [reposError, setReposError] = useState<string | null>(null);
  const [selectedRepo, setSelectedRepo] = useState<string | null>(null);
  const [releases, setReleases] = useState<Release[]>([]);
  const [releasesError, setReleasesError] = useState<string | null>(null);
  const [loadingRepos, setLoadingRepos] = useState(true);
  const [loadingReleases, setLoadingReleases] = useState(false);

  useEffect(() => {
    fetch("/api/github/repos")
      .then((r) => r.json())
      .then((data) => {
        if (Array.isArray(data)) {
          setRepos(data);
        } else {
          setReposError(data.error ?? "Failed to load repositories");
        }
      })
      .catch(() => setReposError("Failed to load repositories"))
      .finally(() => setLoadingRepos(false));
  }, []);

  function selectRepo(fullName: string) {
    setSelectedRepo(fullName);
    setReleases([]);
    setReleasesError(null);
    setLoadingReleases(true);

    fetch(`/api/github/releases?repo=${encodeURIComponent(fullName)}`)
      .then((r) => r.json())
      .then((data) => {
        if (Array.isArray(data)) {
          setReleases(data);
        } else {
          setReleasesError(data.error ?? "Failed to load releases");
        }
      })
      .catch(() => setReleasesError("Failed to load releases"))
      .finally(() => setLoadingReleases(false));
  }

  return (
    <div>
      <p>Signed in as <strong>{login}</strong></p>
      <a href="/api/auth/signout">Sign out</a>

      <h2>Repositories</h2>
      {loadingRepos && <p>Loading…</p>}
      {reposError && <p>Error: {reposError}</p>}
      {!loadingRepos && !reposError && repos.length === 0 && (
        <p>No repositories found.</p>
      )}
      <ul>
        {repos.map((repo) => (
          <li key={repo.id}>
            <button onClick={() => selectRepo(repo.full_name)}>
              {repo.full_name}
              {repo.private ? " (private)" : ""}
            </button>
            {repo.description && <span> — {repo.description}</span>}
          </li>
        ))}
      </ul>

      {selectedRepo && (
        <>
          <h2>Releases — {selectedRepo}</h2>
          {loadingReleases && <p>Loading…</p>}
          {releasesError && <p>Error: {releasesError}</p>}
          {!loadingReleases && !releasesError && releases.length === 0 && (
            <p>No releases found.</p>
          )}
          <ul>
            {releases.map((release) => (
              <li key={release.id}>
                <strong>{release.tag_name}</strong>
                {release.name && release.name !== release.tag_name && (
                  <> — {release.name}</>
                )}
                {release.published_at && (
                  <> ({new Date(release.published_at).toLocaleDateString()})</>
                )}
                {release.draft && <> [draft]</>}
                {release.prerelease && <> [pre-release]</>}
              </li>
            ))}
          </ul>
        </>
      )}
    </div>
  );
}

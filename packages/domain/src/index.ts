export interface Creator {
  id: string;
  githubId: number;
  login: string;
  email: string | null;
}

export interface Project {
  id: string;
  creatorId: string;
  repoFullName: string;
  repoId: number;
}

export interface Release {
  id: string;
  projectId: string;
  tagName: string;
  title: string;
  body: string | null;
  publishedAt: string | null;
  url: string;
  isDraft: boolean;
}

export interface SourceItem {
  tagName: string;
  title: string | null;
  body: string | null;
}

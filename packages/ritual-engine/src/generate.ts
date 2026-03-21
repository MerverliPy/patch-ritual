export type Theme = "quiet" | "bold" | "grateful" | "technical";

export interface GenerateInput {
  title: string;
  releaseBody: string | null;
  whyItMatters: string | null;
  creatorNote: string | null;
  theme: string | null;
}

export interface RitualOutput {
  openingHook: string;
  keyChanges: string[];
  closingPrompt: string;
}

const THEME_OPENERS: Record<Theme, string> = {
  quiet: "A quiet but meaningful step forward.",
  bold: "A bold leap worth celebrating.",
  grateful: "Something to be genuinely grateful for.",
  technical: "A precise and deliberate improvement.",
};

const THEME_CLOSERS: Record<Theme, string> = {
  quiet: "Take a moment to appreciate the small things that add up.",
  bold: "Share this with someone who needs to see what's possible.",
  grateful: "Pause, and let yourself feel good about this one.",
  technical: "Review the diff, understand the trade-offs, and carry it forward.",
};

function resolveTheme(raw: string | null): Theme {
  if (raw === "quiet" || raw === "bold" || raw === "grateful" || raw === "technical") {
    return raw;
  }
  return "quiet";
}

function parseKeyChanges(releaseBody: string | null, fallbackTitle: string): string[] {
  if (!releaseBody || releaseBody.trim() === "") {
    return [fallbackTitle];
  }

  const lines = releaseBody.split("\n");
  const items: string[] = [];

  for (const raw of lines) {
    const line = raw.trim();
    // Match markdown bullets: -, *, + or numbered list: 1. 2. etc.
    const bullet = line.match(/^[-*+]\s+(.+)/) ?? line.match(/^\d+\.\s+(.+)/);
    if (bullet) {
      items.push(bullet[1].trim());
      if (items.length === 5) break;
    }
  }

  return items.length > 0 ? items : [fallbackTitle];
}

export function generateRitual(draft: GenerateInput): RitualOutput {
  const theme = resolveTheme(draft.theme);

  const whyClause = draft.whyItMatters
    ? draft.whyItMatters.trim()
    : THEME_OPENERS[theme];

  const openingHook = `${whyClause} This release — ${draft.title} — marks that progress.`;

  const keyChanges = parseKeyChanges(draft.releaseBody, draft.title);

  const closingPrompt = draft.creatorNote
    ? draft.creatorNote.trim()
    : THEME_CLOSERS[theme];

  return { openingHook, keyChanges, closingPrompt };
}

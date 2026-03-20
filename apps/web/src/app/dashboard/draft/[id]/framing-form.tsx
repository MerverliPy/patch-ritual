"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

interface DraftFields {
  id: string;
  whyItMatters?: string | null;
  creatorNote?: string | null;
  theme?: string | null;
  coverImageUrl?: string | null;
  openingHook?: string | null;
  keyChanges?: string | null;
  closingPrompt?: string | null;
  status?: string | null;
}

interface GeneratedResult {
  openingHook: string;
  keyChanges: string[];
  closingPrompt: string;
}

const THEMES = ["quiet", "bold", "grateful", "technical"] as const;

function parseKeyChanges(raw: string | null | undefined): string[] | null {
  if (!raw) return null;
  try {
    const parsed = JSON.parse(raw) as unknown;
    if (Array.isArray(parsed)) return parsed as string[];
  } catch {
    // ignore
  }
  return null;
}

export default function FramingForm({ draft }: { draft: DraftFields }) {
  const router = useRouter();
  const [whyItMatters, setWhyItMatters] = useState(draft.whyItMatters ?? "");
  const [creatorNote, setCreatorNote] = useState(draft.creatorNote ?? "");
  const [theme, setTheme] = useState(draft.theme ?? "");
  const [coverImageUrl, setCoverImageUrl] = useState(
    draft.coverImageUrl ?? ""
  );
  const [saving, setSaving] = useState(false);
  const [generating, setGenerating] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [saved, setSaved] = useState(
    draft.status === "framed" ||
      draft.status === "generated" ||
      draft.status === "reviewed"
  );

  const existingKeyChanges = parseKeyChanges(draft.keyChanges);
  const [generated, setGenerated] = useState<GeneratedResult | null>(
    draft.status === "generated" || draft.status === "reviewed"
      ? {
          openingHook: draft.openingHook ?? "",
          keyChanges: existingKeyChanges ?? [],
          closingPrompt: draft.closingPrompt ?? "",
        }
      : null
  );

  const [editOpeningHook, setEditOpeningHook] = useState(
    draft.openingHook ?? ""
  );
  const [editKeyChanges, setEditKeyChanges] = useState(
    existingKeyChanges ? existingKeyChanges.join("\n") : ""
  );
  const [editClosingPrompt, setEditClosingPrompt] = useState(
    draft.closingPrompt ?? ""
  );
  const [savingReview, setSavingReview] = useState(false);
  const [reviewSaved, setReviewSaved] = useState(
    draft.status === "reviewed"
  );

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!whyItMatters.trim()) {
      setError("Why it matters is required.");
      return;
    }

    setSaving(true);
    setError(null);
    setSaved(false);

    try {
      const res = await fetch(`/api/drafts/${draft.id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          whyItMatters: whyItMatters.trim(),
          creatorNote: creatorNote.trim() || null,
          theme: theme || null,
          coverImageUrl: coverImageUrl.trim() || null,
        }),
      });

      if (!res.ok) {
        const data = (await res.json()) as { error?: string };
        setError(data.error ?? "Save failed");
        return;
      }

      setSaved(true);
      router.refresh();
    } catch {
      setError("Save failed");
    } finally {
      setSaving(false);
    }
  }

  async function handleGenerate() {
    if (!whyItMatters.trim()) {
      setError("Save framing first — why it matters is required.");
      return;
    }

    setGenerating(true);
    setError(null);

    try {
      const res = await fetch(`/api/drafts/${draft.id}/generate`, {
        method: "POST",
      });

      if (!res.ok) {
        const data = (await res.json()) as { error?: string };
        setError(data.error ?? "Generation failed");
        return;
      }

      const data = (await res.json()) as {
        openingHook?: string;
        keyChanges?: string[];
        closingPrompt?: string;
      };

      const result = {
        openingHook: data.openingHook ?? "",
        keyChanges: data.keyChanges ?? [],
        closingPrompt: data.closingPrompt ?? "",
      };
      setGenerated(result);
      setEditOpeningHook(result.openingHook);
      setEditKeyChanges(result.keyChanges.join("\n"));
      setEditClosingPrompt(result.closingPrompt);
      setReviewSaved(false);
      router.refresh();
    } catch {
      setError("Generation failed");
    } finally {
      setGenerating(false);
    }
  }

  async function handleSaveReview(e: React.FormEvent) {
    e.preventDefault();
    setSavingReview(true);
    setError(null);
    setReviewSaved(false);

    const keyChangesArray = editKeyChanges
      .split("\n")
      .map((s) => s.trim())
      .filter(Boolean);

    try {
      const res = await fetch(`/api/drafts/${draft.id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          openingHook: editOpeningHook.trim(),
          keyChanges: JSON.stringify(keyChangesArray),
          closingPrompt: editClosingPrompt.trim(),
        }),
      });

      if (!res.ok) {
        const data = (await res.json()) as { error?: string };
        setError(data.error ?? "Save failed");
        return;
      }

      setReviewSaved(true);
      router.refresh();
    } catch {
      setError("Save failed");
    } finally {
      setSavingReview(false);
    }
  }

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="whyItMatters">
            Why it matters <span aria-hidden="true">*</span>
          </label>
          <textarea
            id="whyItMatters"
            value={whyItMatters}
            onChange={(e) => setWhyItMatters(e.target.value)}
            rows={4}
            required
          />
        </div>

        <div>
          <label htmlFor="creatorNote">Creator note (optional)</label>
          <textarea
            id="creatorNote"
            value={creatorNote}
            onChange={(e) => setCreatorNote(e.target.value)}
            rows={3}
          />
        </div>

        <div>
          <fieldset>
            <legend>Theme</legend>
            {THEMES.map((t) => (
              <label key={t}>
                <input
                  type="radio"
                  name="theme"
                  value={t}
                  checked={theme === t}
                  onChange={() => setTheme(t)}
                />
                {t}
              </label>
            ))}
          </fieldset>
        </div>

        <div>
          <label htmlFor="coverImageUrl">Cover image URL (optional)</label>
          <input
            id="coverImageUrl"
            type="url"
            value={coverImageUrl}
            onChange={(e) => setCoverImageUrl(e.target.value)}
          />
        </div>

        {error && <p role="alert">{error}</p>}
        {saved && <p>Framing saved.</p>}

        <button type="submit" disabled={saving}>
          {saving ? "Saving…" : "Save framing"}
        </button>
      </form>

      <div>
        <button
          type="button"
          onClick={handleGenerate}
          disabled={generating || !whyItMatters.trim()}
        >
          {generating ? "Generating…" : "Generate ritual"}
        </button>
      </div>

      {generated && (
        <section>
          <h2>Generated Ritual</h2>

          <form onSubmit={handleSaveReview}>
            <div>
              <label htmlFor="editOpeningHook">Opening hook</label>
              <textarea
                id="editOpeningHook"
                value={editOpeningHook}
                onChange={(e) => setEditOpeningHook(e.target.value)}
                rows={3}
              />
            </div>

            <div>
              <label htmlFor="editKeyChanges">
                Key changes (one per line)
              </label>
              <textarea
                id="editKeyChanges"
                value={editKeyChanges}
                onChange={(e) => setEditKeyChanges(e.target.value)}
                rows={5}
              />
            </div>

            <div>
              <label htmlFor="editClosingPrompt">Closing prompt</label>
              <textarea
                id="editClosingPrompt"
                value={editClosingPrompt}
                onChange={(e) => setEditClosingPrompt(e.target.value)}
                rows={3}
              />
            </div>

            {reviewSaved && <p>Ritual reviewed and saved.</p>}

            <button type="submit" disabled={savingReview}>
              {savingReview ? "Saving…" : "Save reviewed ritual"}
            </button>
          </form>
        </section>
      )}

      <p>
        <a href="/dashboard">← Back to workspace</a>
      </p>
    </div>
  );
}

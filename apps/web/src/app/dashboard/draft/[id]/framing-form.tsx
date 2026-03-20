"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

interface DraftFields {
  id: string;
  whyItMatters?: string | null;
  creatorNote?: string | null;
  theme?: string | null;
  coverImageUrl?: string | null;
  status?: string | null;
}

const THEMES = ["quiet", "bold", "grateful", "technical"] as const;

export default function FramingForm({ draft }: { draft: DraftFields }) {
  const router = useRouter();
  const [whyItMatters, setWhyItMatters] = useState(draft.whyItMatters ?? "");
  const [creatorNote, setCreatorNote] = useState(draft.creatorNote ?? "");
  const [theme, setTheme] = useState(draft.theme ?? "");
  const [coverImageUrl, setCoverImageUrl] = useState(
    draft.coverImageUrl ?? ""
  );
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [saved, setSaved] = useState(draft.status === "framed" || draft.status === "generated" || draft.status === "reviewed");

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

  return (
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

      <p>
        <a href="/dashboard">← Back to workspace</a>
      </p>
    </form>
  );
}

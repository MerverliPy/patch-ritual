import { describe, it, expect } from "vitest";
import { generateRitual } from "./generate.js";
import type { GenerateInput } from "./generate.js";

const base: GenerateInput = {
  title: "v1.2.0",
  releaseBody: null,
  whyItMatters: null,
  creatorNote: null,
  theme: null,
};

describe("generateRitual", () => {
  it("returns all three required fields", () => {
    const result = generateRitual(base);
    expect(result).toHaveProperty("openingHook");
    expect(result).toHaveProperty("keyChanges");
    expect(result).toHaveProperty("closingPrompt");
  });

  it("falls back to title as single key change when releaseBody is null", () => {
    const result = generateRitual({ ...base, releaseBody: null });
    expect(result.keyChanges).toEqual(["v1.2.0"]);
  });

  it("falls back to title as single key change when releaseBody is empty", () => {
    const result = generateRitual({ ...base, releaseBody: "   " });
    expect(result.keyChanges).toEqual(["v1.2.0"]);
  });

  it("extracts bullet items from releaseBody", () => {
    const body = `
- Fix login bug
* Add dark mode
+ Improve performance
`;
    const result = generateRitual({ ...base, releaseBody: body });
    expect(result.keyChanges).toEqual([
      "Fix login bug",
      "Add dark mode",
      "Improve performance",
    ]);
  });

  it("extracts numbered list items from releaseBody", () => {
    const body = `
1. First change
2. Second change
`;
    const result = generateRitual({ ...base, releaseBody: body });
    expect(result.keyChanges).toEqual(["First change", "Second change"]);
  });

  it("caps key changes at 5 items", () => {
    const body = Array.from({ length: 8 }, (_, i) => `- Change ${i + 1}`).join("\n");
    const result = generateRitual({ ...base, releaseBody: body });
    expect(result.keyChanges).toHaveLength(5);
  });

  it("includes the draft title in the opening hook", () => {
    const result = generateRitual({ ...base, title: "Release Alpha" });
    expect(result.openingHook).toContain("Release Alpha");
  });

  it("uses whyItMatters in the opening hook when provided", () => {
    const result = generateRitual({
      ...base,
      whyItMatters: "This matters because users were blocked",
    });
    expect(result.openingHook).toContain("This matters because users were blocked");
  });

  it("uses creatorNote as closing prompt when provided", () => {
    const result = generateRitual({
      ...base,
      creatorNote: "Try it and let us know what you think.",
    });
    expect(result.closingPrompt).toBe("Try it and let us know what you think.");
  });

  describe("theme phrasing", () => {
    it("bold theme uses bold opener when no whyItMatters", () => {
      const result = generateRitual({ ...base, theme: "bold" });
      expect(result.openingHook).toContain("A bold leap worth celebrating.");
    });

    it("grateful theme uses grateful opener when no whyItMatters", () => {
      const result = generateRitual({ ...base, theme: "grateful" });
      expect(result.openingHook).toContain("Something to be genuinely grateful for.");
    });

    it("technical theme uses technical closer when no creatorNote", () => {
      const result = generateRitual({ ...base, theme: "technical" });
      expect(result.closingPrompt).toContain("Review the diff");
    });

    it("quiet theme uses quiet closer when no creatorNote", () => {
      const result = generateRitual({ ...base, theme: "quiet" });
      expect(result.closingPrompt).toContain("small things");
    });

    it("unknown theme falls back to quiet", () => {
      const result = generateRitual({ ...base, theme: "nonexistent" });
      expect(result.closingPrompt).toContain("small things");
    });
  });

  describe("determinism", () => {
    it("returns identical output for identical input", () => {
      const input: GenerateInput = {
        title: "v2.0.0",
        releaseBody: "- Rewrote the core\n- Added new API",
        whyItMatters: "This was a big one",
        creatorNote: null,
        theme: "bold",
      };
      const first = generateRitual(input);
      const second = generateRitual(input);
      expect(first).toEqual(second);
    });
  });
});

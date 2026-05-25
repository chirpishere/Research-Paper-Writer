---
name: research-paper-writer
description: End-to-end research paper writing assistant for ML/CV/NLP/systems papers. Runs a structured 7-phase workflow: interview the user to build shared paper understanding, build a reference index from source PDFs, track section status, write sections one at a time using section-specific guides, convert markdown to LaTeX via pandoc, and export a zip for Overleaf. Use when starting a new paper, drafting or revising any section, or preparing a submission-ready LaTeX package.
---

# Research Paper Writer

## Overview

This skill runs a 7-phase workflow to take a paper from idea to submission-ready LaTeX. Each phase is gated by user approval before moving forward. The skill loads only the section guide it needs for the current task — never all guides at once.

**Paper folder convention**: see `paper-structure.md`.
**Interview guide**: see `grill-me.md`.
**Index builder**: see `agents/index-builder.md`.
**Section guides**: see `references/<section>.md`.

---

## Phase 0 — Setup Check

Before anything else, verify the paper project folder exists with the expected structure:

```
paper/
├── main.tex
├── docs/
├── sections_md/
├── sections/
└── scripts/
    ├── md_to_tex.sh
    └── export_overleaf.sh
```

If the folder or any subfolders are missing, offer to scaffold from `paper-template/` in this skill folder. User copies `paper-template/` to their project and renames it `paper/`.

---

## Phase 1 — Grill-Me (Interview)

Load `grill-me.md` and run the interview. Do not skip this phase — all section writing depends on the shared understanding built here.

The interview produces a compact 1-page internal summary (kept in conversation context only, not written to disk) covering: problem, contributions, method, evaluation, deployment, limitations, venue.

End condition: 95% confidence in the paper's story, no major ambiguities.

---

## Phase 2 — Index Build

If `paper/docs/` contains PDF files, spawn the index-builder subagent (see `agents/index-builder.md`) to create or update `paper/index.md`.

Skip if `paper/index.md` already exists and the user confirms it is current.

After `paper/index.md` is written, use it as the sole reference for all `[N]` citation numbers. Never invent citation numbers not in the index.

---

## Phase 3 — Section Checklist

List all sections and their current status. Ask the user which section to work on next.

Status legend:
- `[ ] not started` — `sections_md/<name>.md` does not exist
- `[ ] empty` — file exists but contains only a placeholder or heading
- `[~] draft` — has content, not yet reviewed by user
- `[x] done` — user has approved this section

Standard section order:
1. Abstract
2. Keywords
3. Introduction
4. Related Work
5. Methodology / Method
6. Implementation *(if applicable)*
7. Experiments / Evaluation
8. Conclusion
9. References

Do not proceed to a section without user instruction.

---

## Phase 4 — Section Writing

Load the matching section guide from `references/<section>.md` before writing. Write one section at a time. Do not write multiple sections in a single turn.

Before writing prose:
1. Build a mini-outline (3–7 bullets) and show it to the user.
2. Wait for approval or revisions to the outline.
3. Write the section paragraph by paragraph.

Write the output to `sections_md/<section>.md`.

**Citation rule**: use `[N]` numbers from `paper/index.md` only. Place citations at the point of the claim they support, not at the end of the paragraph.

**Content rules** (apply globally):
- One paragraph = one message. State the paragraph's message in its first sentence.
- Make nouns self-contained — define terms before reusing them.
- Sentence-to-sentence flow: cause, contrast, consequence, or refinement.
- No padding. If a claim cannot be supported by results, weaken or remove it.
- Terminology must be stable across the full paper.

After writing, run a quick self-review:
- Every major claim in Abstract/Introduction has corresponding experimental evidence.
- No unsupported superlatives ("state-of-the-art", "significant", "dramatically").
- All cited papers appear in `paper/index.md`.

---

## Phase 5 — LaTeX Sync

After any section write, remind the user to run:

```bash
bash paper/scripts/md_to_tex.sh
```

This regenerates `paper/sections/*.tex` from the markdown source. The skill does not run this automatically — the user controls when `.tex` files are updated.

---

## Phase 6 — Paper Review

Load `references/paper-review.md`. Run the adversarial 5-dimension checklist:
1. Contribution clarity
2. Writing clarity
3. Experimental strength
4. Evaluation completeness
5. Method design soundness

Output a prioritized revision action list. Resolve all high-risk items before export.

---

## Phase 7 — Export

Run the export script to produce a timestamped zip:

```bash
cd paper && bash scripts/export_overleaf.sh
```

The script regenerates `.tex` from markdown first, then zips `main.tex + sections/ + figures/`.

Output: `overleaf_YYYYMMDD_HHMMSS.zip`

Upload to Overleaf: New Project → Upload Project → select the zip.

---

## Global Principles

1. Load only the section guide needed for the current task.
2. Build outline → get user approval → write prose. Never skip the outline step.
3. Treat `paper/index.md` as the citation authority. Never invent `[N]` numbers.
4. `sections_md/` is the source of truth. `sections/` is derived. Never edit `.tex` files manually.
5. Iterate with adversarial self-review: read every paragraph as a skeptical reviewer.
6. Treat visual quality (tables, figures) as core content, not decoration.
7. Keep terminology stable. Pick one name per concept and use it everywhere.

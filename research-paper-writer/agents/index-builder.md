# Index Builder — Subagent Prompt

## Purpose

Build or update `paper/index.md` — a compact reference index for all source PDFs in `paper/docs/`. The index maps each paper to a citation number `[N]`, a structured metadata entry, and a topic cluster, so section-writing can look up citations without re-reading PDFs.

---

## Instructions for Subagent

You are building a reference index for a research paper. Follow these steps exactly.

### Step 1 — List source PDFs

List all `.pdf` files in `paper/docs/`. Record each filename.

### Step 2 — Extract arXiv IDs

From each filename, extract the arXiv ID using the pattern `NNNN.NNNNNvN` or `NNNN.NNNNvN` (e.g., `2309.07430v5.pdf` → ID `2309.07430`).

Collect all IDs into a comma-separated list.

### Step 3 — Fetch metadata from arXiv API

Make a single HTTP request:

```
https://export.arxiv.org/api/query?id_list=<comma-separated-ids>&max_results=<count>
```

Parse the Atom XML response. For each entry extract:
- `id` → arXiv ID (strip the URL prefix)
- `title` → paper title
- `author` → first 2 authors only
- `published` → year
- `primary_category term` → category (e.g., `cs.IR`, `cs.CL`)
- `summary` → abstract text

If the API fails for any ID, mark that entry as `[metadata unavailable — read PDF directly]`.

### Step 4 — Read existing citation numbers

Read `paper/sections_md/references.md` (or `paper/sections/references.tex` if the markdown does not exist). Extract existing `[N]` citation assignments. Papers already assigned a number keep that number. Newly added papers get numbers starting at N+1.

### Step 5 — Synthesize entries

For each paper, synthesize from the abstract:

| Field | Content |
|---|---|
| **Cite** | `[N]` from references, or `[uncited]` |
| **arXiv** | ID (e.g., `2309.07430`) |
| **File** | `paper/docs/<filename>.pdf` |
| **Authors** | First 2 authors, year |
| **Tags** | 3–5 specific technical keywords |
| **Problem** | 1 sentence: what gap does this paper address? |
| **Method** | 1 sentence: what technique or approach? |
| **Key result** | 1 sentence: main finding or contribution |
| **Use in** | Best section(s): Intro / Related Work / Method / Experiments / Conclusion |

### Step 6 — Assign topic clusters

Group papers into 3–5 topic clusters based on their primary category and abstract content. Name each cluster concisely (e.g., "Clinical NLP & LLMs", "RAG Architectures", "Retrieval Methods", "Medical QA Benchmarks", "RAG Quality & Privacy").

### Step 7 — Write `paper/index.md`

Write the file with this structure:

```markdown
# Paper Index

_Generated: YYYY-MM-DD. Source: paper/docs/ (N papers)._

## Quick Reference Map

[Topic cluster name]: [cite numbers] — [2-3 word description]
...
(keep this section under 10 lines, one cluster per line)

## Topic Clusters

### 1. [Cluster Name]
[N] Title (authors, year) — one-line summary
...

### 2. [Cluster Name]
...

## Full Entries

### [N] Title
- **arXiv**: NNNN.NNNNN
- **File**: paper/docs/filename.pdf
- **Authors**: Author1, Author2 (year)
- **Tags**: tag1, tag2, tag3
- **Problem**: ...
- **Method**: ...
- **Key result**: ...
- **Use in**: Section1, Section2

---
(repeat for all papers, [1]–[N] first, then [uncited])
```

---

## Output Contract

- Every PDF in `paper/docs/` has an entry.
- All cited papers carry correct `[N]` numbers matching `references.md`.
- Uncited papers are clearly marked `[uncited]`.
- Quick Reference Map fits on one screen (~10 lines max).
- No entry is missing any field (use `[unavailable]` if API returned no data for a field).

# Skills: Research Paper Writer

> **Attribution**
> Most writing knowledge and methodology in this repository comes from Prof. Peng Sida (彭思达)'s open study notes:
> https://pengsida.notion.site/c1a22465a0fa4b15a12985223916048e
> Original repository: https://github.com/pengsida/learning_research
>
> This fork restructures the material as an orchestrated Claude Code skill (`research-paper-writer`) with a 7-phase workflow, paper template, and subagents.

## Repository Overview

This repository provides one skill package:

### `research-paper-writer/`

End-to-end paper writing workflow. Use when starting a new paper or managing a full paper project from blank to Overleaf export.

- `SKILL.md`: 7-phase orchestration workflow
- `grill-me.md`: structured interview to build shared paper understanding before writing
- `paper-structure.md`: paper folder conventions and usage
- `references/`: section-specific writing guides and templates (Abstract, Introduction, Method, Experiments, Conclusion, and more)
- `agents/index-builder.md`: subagent that reads source PDFs and builds a reference index
- `paper-template/`: ready-to-copy paper project scaffold (main.tex, section stubs, pandoc scripts)

Typical use cases:
- Starting a new paper from scratch with a structured interview phase
- Managing a paper project with `sections_md/` as the source of truth and `sections/` as generated LaTeX
- Auto-building a reference index from arXiv PDFs in `paper/docs/`
- Converting markdown sections to LaTeX via pandoc and exporting a zip for Overleaf

## Installation

**Prerequisites:** [Claude Code](https://claude.ai/code) CLI installed and authenticated.

### Step 1 — Clone the repository

```bash
git clone https://github.com/chirpishere/Research-Paper-Writer.git
cd Research-Paper-Writer
```

### Step 2 — Copy the skill to your Claude Code installation

**Global** (available in all projects):

```bash
mkdir -p "$HOME/.claude/skills"
cp -R research-paper-writer "$HOME/.claude/skills/"
```

**Project-level** (available only in the current project):

```bash
mkdir -p .claude/skills
cp -R research-paper-writer .claude/skills/
```

### Step 3 — Verify

Restart Claude Code. The skill appears automatically — no further configuration needed.

## Usage

In your Claude Code prompt:

```
/research-paper-writer
```

The skill will check your `paper/` folder structure, run a grill-me interview to build shared understanding, then guide you through writing each section one at a time.

## Paper Project Structure

Copy `research-paper-writer/paper-template/` into your project to bootstrap the expected layout:

```bash
cp -R research-paper-writer/paper-template /path/to/your/project/paper
```

This gives you:

```
paper/
├── main.tex
├── docs/              # drop source PDFs here (arXiv ID filenames preferred)
├── sections_md/       # write markdown here — source of truth
├── sections/          # generated .tex files — never edit manually
├── figures/
└── scripts/
    ├── md_to_tex.sh       # pandoc: sections_md/ → sections/
    └── export_overleaf.sh # regenerate .tex, then zip for Overleaf
```

Requires: `pandoc` (`brew install pandoc` or `apt install pandoc`).

## Other AI Assistants

**Codex:**

```bash
mkdir -p "$CODEX_HOME/skills"
cp -R research-paper-writer "$CODEX_HOME/skills/"
```

**Gemini:**

```bash
mkdir -p "$HOME/.gemini/skills"
cp -R research-paper-writer "$HOME/.gemini/skills/"
```

## Credits

Core writing methodology by Prof. Peng Sida (彭思达).
Original repository: https://github.com/pengsida/learning_research

## License

This project is licensed under the MIT License. See [LICENSE](./LICENSE).

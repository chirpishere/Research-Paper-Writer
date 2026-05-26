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

## Quick Start

After completing installation above:

**1. Set up your paper project folder**

Navigate to your paper project directory and copy the template:

```bash
cd /path/to/your/paper/project
cp -R "$HOME/.claude/skills/research-paper-writer/paper-template" ./paper
```

Install pandoc if you don't have it:

```bash
brew install pandoc       # macOS
# or
apt install pandoc        # Linux
```

**2. Run the skill**

Open Claude Code in your paper project directory and type:

```
/research-paper-writer
```

The skill will verify the `paper/` folder structure, run a structured interview to build shared paper understanding, then guide you through writing each section one at a time.

**3. Write sections**

Edit markdown files in `paper/sections_md/`. When ready to sync to LaTeX:

```bash
bash paper/scripts/md_to_tex.sh
```

**4. Export for Overleaf**

```bash
bash paper/scripts/export_overleaf.sh
```

This produces a timestamped `overleaf_YYYYMMDD_HHMMSS.zip`. Upload via Overleaf → New Project → Upload Project.

## Paper Project Structure

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

## Credits

Core writing methodology by Prof. Peng Sida (彭思达).
Original repository: https://github.com/pengsida/learning_research

## License

This project is licensed under the MIT License. See [LICENSE](./LICENSE).

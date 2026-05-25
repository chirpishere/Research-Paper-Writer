# Grill-Me — Paper Interview Guide

## Purpose

Build a complete shared understanding of the paper before any writing begins. The output is a compact mental model of the paper's story, kept in conversation context. Nothing is written to disk.

Do not rush. If an answer is vague or inconsistent, probe it. A bad answer in the interview produces a bad paper.

---

## Rules

- Ask one category at a time. Within a category, ask follow-ups before moving on.
- Give your own recommended answer when you have one — the user may confirm or correct.
- If you can answer a question by reading the codebase or existing sections, do that instead of asking.
- Track open ambiguities. Do not declare completion until all are resolved.

---

## Interview Categories

### 1. Problem & Gap

> What problem does this paper solve?

- What existing approach do most practitioners use today?
- What specifically fails about that approach? (precision? privacy? latency? domain mismatch?)
- Why hasn't the failure been addressed yet? (hard problem? no dataset? wrong framing?)
- Why is now the right time to solve it?

### 2. Contributions

> What are the 2–3 contributions?

For each contribution:
- State it in one sentence as a technical claim, not a description ("We show that X improves Y by Z" not "We propose a method for...").
- What makes it non-obvious? What would a naive reader assume instead?
- Is it a new method, a new finding, a new system, or a new benchmark?

### 3. System / Method

> Walk me through the pipeline end to end.

- What are the stages, in order?
- For each stage: what is the input, what is the output, what design choice was made and why?
- Where did you diverge from a standard approach, and what motivated the divergence?
- What is the single most important design decision in the paper?

### 4. Evaluation

> How is the system evaluated?

- What dataset(s)? Synthetic, semi-synthetic, real-world?
- How many examples? How were they collected or generated?
- What metrics? Why these metrics and not others?
- What are the main quantitative results? (give numbers)
- What does the ablation study isolate? What are the key positive and negative results?

### 5. Deployment / Impact

> Who uses this, and under what constraints?

- What is the deployment environment? (hospital, cloud, edge, air-gapped?)
- Are there privacy or compliance constraints? (HIPAA, GDPR, DPDP?)
- What does this system enable that wasn't possible before?

### 6. Limitations

> What does this system NOT handle?

- What query types or data types are out of scope?
- What assumptions does the method rely on that may not hold in the wild?
- What would a reviewer say is the weakest part of the evaluation?

Distinguish limitation types:
- **Scope limitation**: bounded by current task setting, still competitive within scope.
- **Technical defect**: underperforms on a metric or causes an unacceptable tradeoff.

Only scope limitations belong in the conclusion. Technical defects must be addressed in the paper.

### 7. Venue & Audience

> Where is this going and who will review it?

- Target conference or journal?
- Primary reviewer background? (systems? NLP? clinical informatics? ML?)
- Page limit and format? (IEEE two-column, ACL, NeurIPS, arXiv preprint?)
- Any co-authors or institutional constraints on claims?

---

## Completion Signal

When all 7 categories are answered with no major ambiguities remaining:

> "I'm 95% confident in the paper's story. Here's my one-paragraph summary of what we're writing:
>
> *[summary: problem, gap, 3 contributions, key result, deployment context, 1 limitation]*
>
> Does this match your intent? If yes, proceed with `/research-paper-writer` to begin writing sections."

If the user corrects the summary, update and re-confirm before proceeding.

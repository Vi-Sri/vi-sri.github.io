# Obsidian vault responsibilities and writing workflow

**Purpose:** Define what belongs in every vault folder and how raw material becomes a reviewed blog article.
**Last verified:** July 23, 2026, America/New_York
**Vault:** `Personal-notes`
**Public board:** <https://tummo.ai/writing/>

This document is the operational guide for everyday research and writing. The
vault is the source of truth for article prose and front matter. It is not a
mirror of the generated Jekyll repository.

## 1. The governing idea

The vault is a promotion pipeline:

```text
raw intake
→ verified source record
→ human synthesis
→ human-owned article draft
→ reviewed compiler export
→ GitHub pull request
→ tummo.ai
```

Folder location communicates maturity and provenance. Moving an idea forward is
a deliberate human decision, not an automatic copy operation.

The strongest intake rule is:

> Every raw clip, unverified reference, and piece of AI-generated content must
> enter through `00 Inbox`.

AI output is not evidence. A plausible citation is not a verified citation. A
Web Clipper capture is not article prose. None of these may go directly into
`10 Sources`, `20 Concepts`, or `30 Drafts`.

In this rule, AI-generated content means research material, summaries,
outlines, citation leads, equations, code, and candidate article prose.
Operational files such as the Vault Guide, templates, and Publishing Board
remain in their functional locations.

## 2. Folder responsibilities

### `00 Inbox`

Purpose: temporary holding area for untrusted, unverified, or unprocessed
material.

Everything external enters here first:

- browser captures;
- article and paper links;
- DOI or bibliography leads;
- PDFs awaiting inspection;
- reader suggestions;
- quotations awaiting verification;
- voice-note transcripts;
- AI-generated summaries;
- AI-generated outlines;
- AI-generated candidate prose;
- AI-suggested citations;
- AI-generated equations or code not yet checked.

Inbox material may be useful, wrong, incomplete, copyrighted, misleading, or
malicious. Its presence means only that it is worth triaging.

Do not use Inbox notes as public wikilink targets. Do not set `blog_publish` on
Inbox material.

#### `00 Inbox/Web Clips`

Destination for Obsidian Web Clipper.

Keep:

- original URL;
- title;
- author;
- publisher or venue;
- publication date;
- captured date;
- the raw clipped text needed for private review.

The clip stays private. If it matters, create a separate verified source note.
Do not turn the clip itself into the source note.

#### `00 Inbox/References`

Destination for unverified reference leads:

- a DOI found in another paper;
- a bibliography entry;
- a link suggested by a person or an AI system;
- a paper title without a checked copy;
- a dataset or code repository to evaluate;
- a secondary article whose primary source must be located.

Use the `Reference intake` template. The note remains here until provenance,
claims, relevance, and the best available version have been checked.

#### `00 Inbox/AI Intake`

Destination for all AI-generated content, regardless of model or tool.

Use the `AI intake` template. Record:

- the model or tool when known;
- the task or prompt;
- the raw output;
- claims and citations that require independent verification;
- useful questions;
- the human decision.

Never promote AI prose by moving or copying it verbatim into Sources, Concepts,
or Drafts. Use AI output to discover questions, then verify evidence from
authoritative sources and write the synthesis in your own words.

### `10 Sources`

Purpose: clean, human-verified records of sources that materially inform the
project.

A source note is different from an Inbox item:

| Inbox | Sources |
|---|---|
| Raw or unverified | Provenance checked |
| May contain copied capture text | Contains a concise evidence record |
| May come from AI or a secondary mention | Based on the actual source |
| Records a lead | Records what the source establishes |
| No publication authority | Can support a claim after appropriate review |

Use one source note per paper, book chapter, dataset, code release, talk, or
authoritative web resource when it matters to the argument.

A good source note contains:

- exact citation and stable URL or DOI;
- source type and version;
- claim relevant to this project;
- evidence and method;
- variables, assumptions, sample, or system;
- important result with a precise locator;
- limitations and counterevidence;
- quotations still requiring exact verification;
- connections to concept notes and candidate drafts.

Sources remains private. Public articles should cite the external stable source,
not expose private source notes.

### `20 Concepts`

Purpose: reusable, human-authored synthesis across verified sources.

A concept note answers questions such as:

- What does this term mean in each relevant field?
- What is the mechanism or formal object?
- Which observations does it explain?
- What are the competing definitions?
- Where does the cross-disciplinary analogy work?
- Where does it fail?
- Which counterexamples matter?
- What experiment or observation could discriminate explanations?

Concept notes are not literature dumps and not article drafts. They should be
compact enough to reuse across several articles.

Examples include:

- computation;
- representation;
- information;
- emergence;
- agency;
- agent boundary;
- goal-directedness;
- error correction;
- open-endedness;
- universality;
- morphology;
- implementation.

Concept notes remain private by default. An exported draft cannot wikilink to a
private concept note. Express the idea in the article, cite a public source, or
create a separate public note after review.

### `30 Drafts`

Purpose: canonical article prose and front matter.

This is the only vault folder scanned for blog publication. Every blog article,
including a published article, keeps its canonical source here.

Do not move a finished article to `40 Published`. Moving it would make the
compiler report its generated post as an orphan.

Each draft has two independent state controls:

| Property | Question |
|---|---|
| `status` | How mature is the article? |
| `blog_publish` | May the complete note leave the private vault? |

Allowed editorial states:

- `todo`: the question exists, but substantive work has not begun;
- `in-progress`: research, writing, derivation, or experiments are underway;
- `published`: the article passed the publication gate.

Privacy:

- `blog_publish: false`: private, regardless of status;
- `blog_publish: true`: eligible for compiler export and public visibility.

An unfinished exported article is publicly readable by URL even though it is
`noindex`. Never treat `noindex` as confidentiality.

Draft prose should be human-owned. Raw AI output stays in Inbox. A draft may use
verified facts, equations, or research questions discovered during AI-assisted
research only after the author independently checks and rewrites them.

### `40 Published`

Purpose: post-publication operational notes, not canonical article sources.

Good uses:

- correction logs;
- reviewer or reader responses;
- follow-up questions;
- distribution notes;
- release notes;
- post-publication measurement snapshots;
- ideas for a revised edition.

The canonical published article remains in `30 Drafts` with
`status: published`.

### `90 Templates`

Purpose: approved structures for consistent notes.

Templates include:

- Blog draft;
- Source note;
- Reference intake;
- AI intake;
- Concept note.

Use a template rather than inventing a new metadata vocabulary for each note.

### `Attachments`

Purpose: local binary files used by notes.

Examples:

- images;
- diagrams;
- datasets;
- PDFs;
- JSON;
- ZIP artifacts.

An attachment is private unless an opted-in draft embeds it. During sync,
supported embedded files are copied into a slug-specific public asset folder.
Merely storing a file in Attachments does not publish it.

## 3. The local publishing board

Open `Publishing Board.md` in Obsidian.

It contains three dynamic Dataview sections:

- Todo;
- In progress;
- Published.

The board reads properties directly from every note in `30 Drafts`. It shows:

- the article link;
- content type;
- next step;
- private or public-roadmap visibility;
- updated date.

Do not drag cards or maintain duplicate status text. Edit the source draft:

```yaml
status: in-progress
next_step: "Verify the Fisher metric derivation and build the first figure."
blog_publish: false
```

Dataview updates the Obsidian board automatically.

The website board uses the same draft properties, but only after the compiler
and deployment pipeline:

```text
edit draft properties in Obsidian
→ local Publishing Board updates immediately
→ bin/blog check
→ bin/blog sync
→ generated post changes
→ Git pull request and merge
→ GitHub Pages deploys
→ tummo.ai/writing updates
```

The local board may include private drafts. The public board never does.

As of July 23, 2026, both the live board and the opted-in vault snapshot show:

| Stage | Count | Articles |
|---|---:|---|
| Todo | 2 | Civilization; Fourier transforms |
| In progress | 3 | Statistical manifolds; Maze solving; Pinecones |
| Published | 0 | None |

## 4. Daily research workflow

### Step 1: capture

Send all external or AI material to the correct Inbox subfolder.

- Web Clipper: `00 Inbox/Web Clips`
- unverified paper or reference: `00 Inbox/References`
- AI output: `00 Inbox/AI Intake`

Do not decide publication state during capture.

### Step 2: triage

For each Inbox item, record:

1. Which live question could this inform?
2. What exact claim needs verification?
3. Is this primary evidence, a review, commentary, or only a lead?
4. What is the original source?
5. What method produced the result?
6. What evidence would contradict it?
7. Is it worth processing now?

Leave, archive, or delete Inbox items only by deliberate choice. A research chat
must not broadly clean the Inbox without permission.

### Step 3: verify references

Open the actual source.

Check:

- author and title;
- venue and date;
- DOI or stable URL;
- version;
- methods and data;
- result being cited;
- limitations;
- exact location of any quotation;
- retraction, correction, or later qualification when relevant.

An AI-provided citation is only a search lead until this step is complete.

### Step 4: create a source note

After verification, create a new note in `10 Sources` using the `Source note`
template.

Do not move the raw clip or AI note into Sources. Keep provenance clean:

- raw input remains in Inbox;
- verified evidence gets a new source note;
- the author's synthesis belongs in Concepts or Drafts.

### Step 5: synthesize concepts

When several sources bear on a reusable idea, create or update a concept note.

Write:

- a working definition;
- disagreements;
- mechanism;
- evidence;
- limits;
- open questions;
- links to verified source notes;
- links to candidate drafts.

This is the stage where the author's intellectual model becomes explicit.

### Step 6: create or update the draft

Create a private draft:

```bash
cd "/Users/svenkatanara/Documents/Blog"
bin/blog new "A precise working title"
```

Or use the Blog draft template in `30 Drafts`.

Start with:

```yaml
status: todo
blog_publish: false
```

Move to `in-progress` when substantive research, writing, math, code, or visual
work begins.

### Step 7: write the article

Develop:

1. the anomaly or question;
2. the naive explanation;
3. the mechanism;
4. where the connection works;
5. where the connection breaks;
6. a discriminating experiment;
7. remaining questions;
8. external references.

Use exact public wikilinks when another public note carries part of the
argument. Private source and concept links are for authoring only and must not
cross into an exported draft.

### Step 8: review locally

From the repository:

```bash
git status --short --branch
bin/blog status
bin/blog normalize-links
bin/blog check
```

Normalization may edit draft links in the vault. Inspect those edits.

### Step 9: authorize export

Only the author decides when the complete note may leave the vault.

For a public work-in-progress:

```yaml
status: in-progress
blog_publish: true
```

For a finished article:

```yaml
status: published
blog_publish: true
```

### Step 10: compile, preview, and publish

```bash
bin/blog check
bin/blog sync
docker compose up -d --build
```

Inspect the generated diff, local page, backlinks, Explore graph, board,
metadata, equations, interactives, and attachments. Then use the reviewed
GitHub pull-request workflow described in `PROJECT_MEMORY.md`.

## 5. What Codex chats may write

The Inbox rule applies to Codex and every other AI tool.

### Research chat

May:

- inspect existing material;
- search for sources;
- create reference leads in `00 Inbox/References`;
- place raw AI summaries, outlines, or candidate passages in
  `00 Inbox/AI Intake`;
- identify claims that require verification;
- help design experiments and questions in chat.

May not by default:

- place AI-generated prose directly into Sources, Concepts, or Drafts;
- claim an AI citation is verified;
- change article privacy or publication state;
- sync, commit, or deploy.

### Human promotion step

The author:

- checks the source;
- decides whether the material is useful;
- writes or approves the source record;
- synthesizes the concept in their own words;
- writes the draft argument;
- authorizes public export.

### Publishing chat

May:

- inspect the approved draft;
- validate metadata, citations, links, math, and artifacts;
- compile and preview;
- publish through GitHub after explicit authorization;
- update project state.

It may not invent research merely to satisfy a build or publishing deadline.

## 6. Quick decision table

| Material | First location | Promotion condition |
|---|---|---|
| Web page captured by Clipper | `00 Inbox/Web Clips` | Verify and create a clean source note |
| Paper title or DOI lead | `00 Inbox/References` | Read the actual source |
| AI summary or outline | `00 Inbox/AI Intake` | Never promote verbatim; verify and rewrite |
| Verified paper record | `10 Sources` | Provenance and relevant claim checked |
| Cross-source definition or model | `20 Concepts` | Human synthesis from verified evidence |
| Article prose | `30 Drafts` | Human-owned argument |
| Correction or reader response | `40 Published` | Article already live |
| Image, data, PDF, or ZIP | `Attachments` | Explicit embed and privacy review |

## 7. Invariants

- Inbox is the only entry point for raw external and AI material.
- Sources contains verified evidence records, not captures or AI prose.
- Concepts contains human synthesis, not copied text.
- Drafts contains the canonical article, even after publication.
- `status` controls editorial stage.
- `blog_publish` controls whether a draft may leave the vault.
- The local board is generated from draft properties.
- The public board is generated from compiled public drafts.
- A public draft cannot link into private vault material.
- The repository never contains the private vault.
- Every deployment is reviewable as a Git diff.

# tummo.ai research and article roadmap

**Purpose:** Shared content context for every Codex chat that researches, writes, reviews, compiles, or publishes work for tummo.ai.
**Last verified:** July 23, 2026, America/New_York
**Planning window:** July 20 to November 17, 2026
**Canonical system guide:** [PROJECT_MEMORY.md](PROJECT_MEMORY.md)

This document describes what the blog is trying to become, every article currently in the four-month plan, the live draft portfolio, the research-to-publication workflow, and the technical contract between Obsidian, the compiler, Jekyll, and GitHub Pages.

It is the content-facing companion to `PROJECT_MEMORY.md`:

- `PROJECT_MEMORY.md` is authoritative for infrastructure, privacy, compiler behavior, deployment, domain, analytics, SEO plumbing, and current operational state.
- This file is authoritative for the editorial portfolio, research questions, planned connections, evidence requirements, visual and mathematical artifacts, and the handoff between research chats and the publishing chat.
- The current Obsidian note is authoritative for article prose and article front matter.
- Git and the deployed site are authoritative for what has actually been compiled and published.

Do not use a previous chat transcript as the source of truth when these files or the vault are available.

## 1. How a new Codex chat should load context

Every chat in this project should first read:

1. `AGENTS.md`
2. `docs/PROJECT_MEMORY.md`

A chat working on a topic, source, concept, article, simulation, or paper should also read:

3. `docs/BLOG_RESEARCH_ROADMAP.md`
4. the current Obsidian source note, if one exists
5. the relevant source and concept notes, only as needed

A publishing or site-maintenance chat should inspect the current Git status and the compiler status before making changes:

```bash
cd "/Users/svenkatanara/Documents/Blog"
git status --short --branch
bin/blog status
```

The chats have different jobs:

| Workstream | Owns | Does not do by default |
|---|---|---|
| Topic research | Sources, source notes, concepts, equations, hypotheses, article prose | Export, Git, pull requests, deployment |
| Editorial and reproducibility | Claims, objections, derivations, simulations, citations, accessibility, readiness review | Publication state changes or deployment |
| Publishing and website | Compiler, generated posts, renderers, graph, board, SEO plumbing, Docker, GitHub Pages | Invent or silently rewrite research claims |

This chat is intended to remain the publishing and website workstream. Separate chats can research individual topics while sharing state through this document, `PROJECT_MEMORY.md`, the vault, and Git.

## 2. Mission, identity, and standards

tummo.ai is a connected research notebook about the recurring architectures behind computation, evolution, morphogenesis, intelligence, and collective behavior.

The central editorial bridge is:

> How do local rules, information flows, physical constraints, memory, selection, and control produce organized behavior across scales?

The subject areas include:

- nature-inspired and evolutionary computation;
- evolution, development, morphogenesis, artificial life, and cellular automata;
- complex adaptive systems, emergence, institutions, and social systems;
- artificial intelligence, agency, cognition, and theory of mind;
- information theory, information geometry, mathematical physics, and statistical physics;
- philosophy of computation, explanation, mind, causality, and existence.

Scientists are used as entrances into mechanisms and disagreements, not as subjects for generic biographies. A piece about Turing, Shannon, von Neumann, Conway, Levin, Penrose, Thompson, Ashby, Holland, Prigogine, Rao, Fourier, Dijkstra, or another researcher must earn its place by clarifying a live question.

The editorial standard is:

- one precise question or claim;
- primary or authoritative sources where available;
- a visible distinction between evidence, inference, speculation, and open questions;
- the strongest serious objection;
- explicit limits on the cross-disciplinary connection;
- a derivation, example, simulation, or discriminating test when appropriate;
- meaningful links to exact arguments elsewhere in the notebook;
- an accessible explanation that does not dilute the mechanism;
- no invented citations, quotations, results, or novelty claims;
- no Unicode em dash in article text, metadata, website copy, or project documentation.

The goal is not a stream of disconnected posts. Each article should improve a navigable body of thought. Search, tags, wikilinks, backlinks, and the Explore graph are different views of that body.

## 3. Four-month outcome

The planning window is July 20 to November 17, 2026. The intended outputs are:

| Output | Target |
|---|---:|
| Flagship essays | 8 |
| Field notes | 12 to 16 |
| Public simulations or notebooks | 4 |
| Reproducible preprints | 1 |
| Monthly research maps | 4 |

Directional audience and reputation signals are:

- 200 email or RSS subscribers;
- 1,000 monthly engaged readers;
- 15 earned referring domains;
- 20 meaningful researcher conversations;
- 3 invitations, citations, or collaborations.

These are not promises. The controllable target is a memorable, citable, technically serious body of work. Raw impressions and posting streaks are secondary.

The planned rhythm is:

- Tuesday: one field note, usually 500 to 900 words;
- every second Thursday: one flagship essay, usually 2,500 to 4,000 words;
- Friday: one build log or experiment report;
- monthly: one expert conversation and one map of what changed.

The detailed calendar and distribution plan remain in [FOUR_MONTH_REVIVAL_PLAN.md](FOUR_MONTH_REVIVAL_PLAN.md).

## 4. Live portfolio snapshot

`bin/blog check` passed on July 23, 2026 with five opted-in drafts. These drafts are publicly visible as unfinished work, but they are `noindex` and excluded from the sitemap until their status becomes `published`.

### 4.1 Current drafts

| Canonical note | Current title | State | Renderers | Role |
|---|---|---|---|---|
| `fourier-transforms-and-images` | Fourier Transforms: Sailing Through Latent Seas | Todo | MathJax | Foundation note on representation |
| `information-theory` | Statistical Manifolds: What Kind of Space Is a Model? | In progress | MathJax | Information geometry and model-space foundation |
| `civilization-patterns` | Civilization as an Adaptive System: Beyond the Techno-Feudalism Metaphor | Todo | None yet | Seed for society and collective-computation work |
| `maze-solving` | Maze Solving as Search, Memory, and Embodied Computation | In progress | MathJax and p5.js | Search, memory, representation, and unconventional computation |
| `pinecone` | Pinecones, Phyllotaxis, and the Computation of Form | In progress | MathJax | Seed for flagship 7 and a phyllotaxis artifact |

Current explicit reference edges include:

- `fourier-transforms-and-images` to an exact section in `information-theory`;
- `maze-solving` to an exact section in `pinecone`;
- `pinecone` to `fourier-transforms-and-images`.

No article is currently in the Published column.

### 4.2 Current draft dossiers

#### Fourier Transforms: Sailing Through Latent Seas

Canonical note: `30 Drafts/fourier-transforms-and-images.md`

Questions already framing the draft:

- What changes and what remains invariant under a Fourier transform?
- How do locality and sparsity change between spatial and frequency representations?
- Which useful properties of convolutional systems are inherited from Fourier structure?
- Where does a fixed Fourier basis clarify learned latent spaces, and where does the analogy fail?

Next research work:

- design image-domain experiments;
- select primary mathematical and signal-processing references;
- build figures showing spatial and frequency localization;
- distinguish an exact transform from a learned representation;
- link to information geometry only where the metric or representation argument is real.

Expected output: a visual mathematical explainer with executable experiments, equations, static figures, and reproducible inputs. It can support the broader information and representation thread without being forced into a flagship topic.

#### Statistical Manifolds: What Kind of Space Is a Model?

Canonical note: `30 Drafts/information-theory.md`

Questions already framing the draft:

- How does the Fisher information metric encode local statistical distinguishability?
- Why should the geometry be invariant under a change of parameter coordinates?
- What is the difference between a statistical manifold and a learned representation manifold?
- When does geometry explain learning behavior, and when is it only a descriptive visualization?

Next research work:

- derive the Fisher metric for at least one tractable family;
- show a reparameterization example;
- separate Shannon information, Fisher information, and informal uses of information;
- create a small geometric visualization with a static fallback;
- audit every claim about C. R. Rao and information geometry against primary or authoritative sources.

Expected output: a rigorous explainer that can support the Shannon flagship while remaining a distinct article.

#### Civilization as an Adaptive System

Canonical note: `30 Drafts/civilization-patterns.md`

Questions already framing the draft:

- What is the unit of selection in an institutional or social explanation?
- How do power, countervailing adaptation, and path dependence alter a simple fitness metaphor?
- Which historical comparisons can discriminate mechanisms?
- What observations would distinguish techno-feudalism, monopoly capitalism, and platform-rent explanations?

Next research work:

- define each proposed mechanism before using adaptive language;
- assemble comparative cases and counterexamples;
- identify what is computed, represented, transmitted, and selected, if computation language is used;
- distinguish an illuminating analogy from a causal model;
- develop this draft as a seed for flagship 8 rather than treating its current framing as settled.

Expected output: a mechanism-first social-systems essay, possibly retitled and substantially rebuilt.

#### Maze Solving as Search, Memory, and Embodied Computation

Canonical note: `30 Drafts/maze-solving.md`

Questions already framing the draft:

- Which solvers require a global graph or map?
- How do memory constraints change completeness and optimality?
- In what sense can slime molds or reaction-diffusion dynamics solve a maze?
- Which part of a solution is performed by an algorithm, an embodiment, or the physical environment?
- What computation appears to come for free only because physics is doing uncounted work?

Next research work:

- formalize a common maze representation and solver comparison;
- implement p5.js views for graph search, local navigation, and a Physarum-inspired embodied solver;
- state complexity, memory, and optimality assumptions;
- use deterministic seeds for comparable runs;
- create a static summary figure and a table of failure modes;
- verify claims involving Dijkstra, A*, Shannon, and Nakagaki.

Expected output: an explainer and interactive experiment line connecting classical search with embodied and unconventional computation.

#### Pinecones, Phyllotaxis, and the Computation of Form

Canonical note: `30 Drafts/pinecone.md`

Questions already framing the draft:

- Which visible regularities follow from packing?
- Which require a developmental mechanism?
- How robust is a divergence-angle explanation to perturbation?
- What can reaction-diffusion, growth, or mechanics explain independently?
- Which simulations reproduce a pattern while failing to reproduce its cause?

Next research work:

- implement a parameterized phyllotaxis simulation;
- separate geometric packing, developmental regulation, and evolutionary explanation;
- show successful and failed regimes;
- connect exact mathematical observations to Fourier only where representation is relevant;
- turn the draft into the factual and visual basis for flagship 7.

Expected output: a flagship synthesis backed by a smaller field note and reproducible visual artifact.

## 5. Planned flagship essays

Working titles and slugs are planning identifiers. Before creating a new note, search the vault for an existing draft, title, slug, or alias. Reuse and evolve the existing note when it is the same argument.

### Flagship 1: A Pattern Is Not a Body

Working canonical name: `pattern-is-not-a-body`

Working title: **A Pattern Is Not a Body: From Turing's Reaction-Diffusion Equations to Levin's Bioelectric Goals**

Core question:

> What does a pattern-forming model explain, and what additional machinery is needed to explain reliable anatomy, repair, and target-directed regulation?

Proposed contribution:

- distinguish spontaneous pattern formation from anatomical error correction;
- compare local chemical instabilities, bioelectric coordination, mechanical constraints, and feedback control;
- identify observations on which the explanations make different predictions;
- explain why reproducing a visual pattern is weaker than reproducing a developmental mechanism.

Evidence and research plan:

- read Turing's 1952 paper closely, including its stated scope;
- identify primary experimental work for reaction-diffusion systems and bioelectric regulation;
- read Levin's relevant primary papers and serious critiques;
- define pattern, morphology, target state, set point, memory, goal, and error correction;
- create a claim-to-source matrix;
- include counterexamples where pattern formation does not yield robust form;
- avoid treating agency language as proven merely because regulation exists.

Math plan:

- introduce a two-species reaction-diffusion system;
- explain the stability intuition before deriving conditions;
- show how diffusion can destabilize a spatially uniform fixed point;
- distinguish model variables from direct biological observables;
- place longer algebra in an appendix or linked notebook.

Visual plan:

- p5.js or a sandboxed interactive for parameter sweeps;
- static phase or regime map;
- before-and-after perturbation sequences;
- explicit failed regimes, not only visually attractive spots.

Reproducibility artifact:

- fixed model equations and parameter table;
- deterministic seeds where noise is used;
- source code and environment;
- exported figures and data;
- clear statement that a simulation is an explanatory model, not direct biological evidence.

Candidate public connections:

- `[[pinecone#Questions this note must answer|the difference between pattern and cause]]`
- `[[what-does-a-cell-know|operational biological agency]]`, after that public target exists
- `[[shannon-without-the-metaphors|information language in biology]]`, after that public target exists

Completion gate:

- the essay states at least one discriminating prediction;
- Turing and Levin are represented from primary work;
- reaction-diffusion, feedback control, mechanics, and observer interpretation are not collapsed;
- the artifact contains failures and perturbations;
- every biological claim has an appropriate source.

### Flagship 2: Shannon Without the Metaphors

Working canonical name: `shannon-without-the-metaphors`

Working title: **Shannon Without the Metaphors: What Information Theory Says, and Does Not Say, About Life**

Core question:

> When does information theory provide a measurable causal or operational account of a living system, and when is information only a suggestive metaphor?

Proposed contribution:

- derive the formal quantities carefully;
- explain why semantic meaning is excluded from the communication problem;
- separate Shannon entropy, algorithmic complexity, Fisher information, semantic information, and causal influence;
- offer a checklist for deciding whether an information claim adds explanatory content.

Evidence and research plan:

- use Shannon's original work and authoritative technical treatments;
- trace later biological uses to their actual definitions;
- collect examples where information measures predict or constrain an experiment;
- collect examples where information language simply renames organization;
- state whether each quantity depends on a distribution, observer, coding choice, model family, or intervention.

Math plan:

- entropy, conditional entropy, mutual information, and channel capacity;
- one small worked communication example;
- one biological example with explicit random variables;
- a sidebar linking Fisher information to `information-theory` without claiming the two theories are interchangeable.

Visual plan:

- static channel diagram;
- interactive probability controls only if they reveal a non-obvious relation;
- glossary cards for overloaded uses of information.

Candidate public connections:

- `[[information-theory|the geometry of statistical distinguishability]]`
- `[[fourier-transforms-and-images|representation in another basis]]`
- `[[pattern-is-not-a-body|signals, states, and biological interpretation]]`, after the target exists
- `[[von-neumanns-machine-that-builds-itself|descriptions used by constructors]]`, after the target exists

Completion gate:

- every information quantity has named variables and assumptions;
- semantic and causal claims are not smuggled into Shannon measures;
- at least one example shows genuine explanatory gain;
- at least one plausible misuse is analyzed fairly;
- terminology remains consistent across the glossary and linked articles.

### Flagship 3: Von Neumann's Machine That Builds Itself

Working canonical name: `von-neumanns-machine-that-builds-itself`

Core question:

> Why does reliable self-reproduction require a description that is both interpreted and copied, and what does that architecture explain about open-ended evolution?

Proposed contribution:

- explain constructor, copier, controller, and description roles;
- clarify the two uses of the description;
- connect the architecture to genotype and phenotype without claiming identity;
- identify what is still missing for open-ended evolution.

Evidence and research plan:

- use von Neumann's primary work and careful historical scholarship;
- reconstruct the logical architecture before discussing later biology;
- distinguish universal construction, self-reproduction, and evolutionary innovation;
- compare with modern artificial-life systems through published mechanisms;
- include limitations of the analogy to cells and genomes.

Math and formal plan:

- use a typed block diagram or symbolic composition of components;
- define the reproduction mapping;
- show where copying errors, inherited descriptions, and construction errors enter;
- avoid unnecessary formalism that does not clarify the architecture.

Visual plan:

- an annotated constructor diagram;
- a step-by-step animation, likely Manim or a lightweight p5.js state machine;
- a static sequence for print and feeds.

Candidate public connections:

- `[[shannon-without-the-metaphors|description, coding, and communication]]`
- `[[why-conways-life-does-not-prove-life-is-computation|universality and explanation]]`
- `[[evolution-without-a-fitness-function|conditions for open-ended novelty]]`

Completion gate:

- the two uses of the description are unmistakable;
- universal construction is not conflated with universal computation;
- the biological analogy includes exact points of match and mismatch;
- the open-endedness section states what self-reproduction alone cannot provide.

### Flagship 4: Why Conway's Life Does Not Prove That Life Is Computation

Working canonical name: `why-conways-life-does-not-prove-life-is-computation`

Core question:

> What follows from computational universality in a cellular automaton, and what additional argument is needed to make a claim about biological life or physical ontology?

Proposed contribution:

- separate universality, emulation, simulation, explanation, and ontology;
- present the strongest computationalist argument;
- show why existence of a simulation is not by itself a causal explanation;
- give conditions under which a cellular automaton does illuminate a living process.

Evidence and research plan:

- verify the relevant formal results and their scope;
- use primary or authoritative sources on Life and universality;
- identify examples where coarse-grained CA models make testable predictions;
- treat digital physics and computationalism as arguments, not settled facts;
- include a short connection to Penrose without turning the essay into a mind argument.

Math and formal plan:

- define a cellular automaton and local update rule;
- distinguish Turing completeness from efficient or natural representation;
- show one observable under coarse graining;
- state what an implementation or encoding assumes.

Visual plan:

- p5.js comparison of several rules and macroscopic observables;
- reader controls for rule, initial condition, and measurement;
- deterministic presets and static regime snapshots.

Candidate public connections:

- `[[von-neumanns-machine-that-builds-itself|construction versus computation]]`
- `[[pattern-is-not-a-body|visual pattern versus causal explanation]]`
- `[[maze-solving|what the substrate contributes to a computation]]`

Completion gate:

- every use of universal or simulate specifies the formal sense;
- the computationalist reply is presented in its strongest form;
- the essay identifies at least one case where a CA model is explanatorily useful;
- ontology is not inferred from mere representability.

### Flagship 5: Evolution Without a Fitness Function

Working canonical name: `evolution-without-a-fitness-function`

Working title: **Evolution Without a Fitness Function: What Open-Ended Search Is Actually Asking For**

Core question:

> Which mechanisms allow persistent novelty when an objective function, representation, and stopping condition are not fixed in advance?

Proposed contribution:

- compare objective optimization, novelty search, quality diversity, coevolution, and open-ended evolution;
- identify which claims are empirical, formal, or aspirational;
- distinguish a changing objective from the emergence of new possibilities;
- propose evaluation criteria that do not quietly restore a fixed fitness target.

Evidence and research plan:

- build a literature matrix of algorithms, environments, novelty mechanisms, and evaluation methods;
- reproduce at least two baseline systems if feasible;
- include negative results and sensitivity to representation;
- define novelty, diversity, complexity, adaptation, and open-endedness;
- compare biological evolution carefully without treating it as a single algorithm.

Math and experiment plan:

- formalize objective and behavior-characterization spaces;
- show a novelty metric and archive update;
- compare outcome distributions, coverage, and robustness;
- preregister the main comparison before interpreting results if it becomes the preprint.

Visual plan:

- p5.js or notebook view of search trajectories and archive coverage;
- static small multiples across seeds;
- tables of assumptions and failure modes.

Candidate public connections:

- `[[von-neumanns-machine-that-builds-itself|heritable descriptions and construction]]`
- `[[information-theory|geometry induced by a representation]]`
- `[[maze-solving|the difference between a task objective and embodied dynamics]]`
- `[[when-does-a-society-compute|adaptation in institutions]]`

Completion gate:

- baselines are fair and reproducible;
- claims survive multiple seeds and representations where appropriate;
- open-endedness is not declared from an attractive trajectory;
- the distinction between exploration and unbounded innovation remains explicit.

### Flagship 6: What Does a Cell Know?

Working canonical name: `what-does-a-cell-know`

Working title: **What Does a Cell Know? Agency Across Biological Scales**

Core question:

> Which observable capacities justify agency language at cellular or multicellular scales without importing human mental concepts?

Proposed contribution:

- define operational tests for memory, preference, error correction, flexible action, and model-based control;
- separate homeostasis, control, learning, agency, cognition, and consciousness;
- examine how the apparent agent boundary changes with the task and scale;
- propose a graded evidence table instead of a binary declaration.

Evidence and research plan:

- identify primary experiments for each claimed capacity;
- describe the intervention, response, alternative explanation, and replication status;
- include skeptical interpretations;
- use Ashby's regulator ideas carefully;
- avoid treating surprising behavior as proof of a mind.

Math and formal plan:

- minimal feedback-control examples;
- state-space or Markov descriptions when they clarify memory;
- operational metrics linked to interventions;
- no equation without an observable interpretation.

Visual plan:

- graded evidence matrix;
- state diagrams for simple memory and control examples;
- interactive only if the reader can test an operational criterion.

Candidate public connections:

- `[[pattern-is-not-a-body|anatomical regulation and target states]]`
- `[[shannon-without-the-metaphors|measured signals versus semantic claims]]`
- `[[maze-solving|memory and embodied problem solving]]`
- `[[pinecone|agency claims in a developmental explanation]]`

Completion gate:

- the word know is operationalized, challenged, and not used literally by default;
- each capacity is tied to an experiment;
- simpler mechanisms remain visible;
- scale and agent-boundary choices are explicit.

### Flagship 7: Pinecones, Primordia, and the Difference Between a Pattern and Its Cause

Canonical note to evolve: `pinecone`

Core question:

> How can the same phyllotactic regularity arise from geometry, growth, mechanics, biochemical signaling, and selection, and which evidence distinguishes those explanations?

Proposed contribution:

- use a familiar natural pattern to teach levels of explanation;
- separate mathematical description from developmental production;
- show that a good visual fit can coexist with a wrong mechanism;
- connect perturbation and failure cases to causal inference.

Evidence and research plan:

- verify botanical and developmental claims with primary or authoritative work;
- reproduce geometric packing models;
- compare with mechanistic developmental models;
- include perturbations and non-ideal specimens;
- distinguish a model of arrangement from a model of organ initiation.

Math plan:

- divergence angles and phyllotactic indexing;
- Fibonacci relationships presented as consequences to explain, not mystical causes;
- sensitivity to parameter changes;
- geometric and mechanistic models labeled separately.

Visual plan:

- p5.js phyllotaxis simulation with controls;
- deterministic presets;
- overlay of idealized and perturbed arrangements;
- static success and failure panels.

Candidate public connections:

- `[[fourier-transforms-and-images|a representation of spatial regularity]]`
- `[[pattern-is-not-a-body|the gap between pattern and anatomy]]`
- `[[what-does-a-cell-know|how much agency an explanation requires]]`

Completion gate:

- packing, development, mechanics, and evolution are not substituted for one another;
- the simulation includes failure modes;
- observational and causal claims are labeled;
- existing `pinecone` wikilinks and aliases remain stable through any title change.

### Flagship 8: When Does a Society Compute?

Working canonical name: `when-does-a-society-compute`

Existing seed to assess: `civilization-patterns`

Working title: **When Does a Society Compute? A Mechanism-First Account of Collective Intelligence**

Core question:

> Under what conditions does computation language explain collective behavior in institutions, markets, or societies rather than merely redescribe coordination?

Proposed contribution:

- require identifiable states, transformations, channels, memory, and outputs;
- compare distributed computation with institutional decision processes;
- analyze incentives, power, strategic behavior, and boundary choices;
- state where computational and evolutionary analogies break.

Evidence and research plan:

- begin with concrete institutional mechanisms and cases;
- compare competing political-economic explanations on predictions;
- identify the unit and timescale of adaptation;
- use collective-intelligence and distributed-systems work carefully;
- avoid naturalizing a social arrangement by calling it evolved or adaptive.

Math and formal plan:

- a small distributed-decision or aggregation model;
- information-flow and error-correction diagrams;
- optional network model only if it tests a claim;
- explicit assumptions about agents, incentives, and communication.

Visual plan:

- mechanism map and counterfactual table;
- interactive network only if the controls expose robustness, bottlenecks, or failure;
- no decorative node cloud.

Candidate public connections:

- `[[civilization-patterns|the current institutional seed note]]`
- `[[shannon-without-the-metaphors|measurable information flow]]`
- `[[evolution-without-a-fitness-function|selection and adaptation without a fixed designer]]`
- `[[what-does-a-cell-know|the problem of choosing an agent boundary]]`

Completion gate:

- the computation claim identifies an implementation and observable;
- power and incentives are not erased by systems language;
- rival explanations receive discriminating predictions;
- analogy limits are part of the main argument, not a disclaimer at the end.

## 6. Field-note slate

Field notes are compact research objects, not reduced flagships. Each should answer one precise question, include one mechanism or example, and point toward a larger argument.

### 6.1 Scientist-led notes already in the plan

| Working note | Precise question | Feeds |
|---|---|---|
| Turing 1952 | What did the morphogenesis model explain, and what did it deliberately leave out? | Flagship 1 and 7 |
| Shannon and semantics | Why is semantic meaning absent from the formal theory, and when is that a feature? | Flagship 2 |
| von Neumann's description | Why is one description used both as instructions and as copied data? | Flagship 3 |
| Conway and universality | What does universality prove about a CA, and what does it not prove about life? | Flagship 4 |
| Levin and target states | Are bioelectric target states goals, control set points, or observer-relative descriptions? | Flagship 1 and 6 |
| Penrose's empirical step | Which step in the uncomputability argument concerns the actual human mind, and what observation could bear on it? | Future mind series and flagship 4 |
| D'Arcy Thompson and constraint | When does physical constraint explain biological form without replacing evolution? | Flagship 7 |
| Ashby and requisite variety | How do regulation and requisite variety depend on the chosen agent boundary? | Flagship 6 and 8 |
| Holland and complex adaptive systems | Which parts of the framework became operational, and which remained metaphorical? | Flagship 5 and 8 |
| Prigogine and dissipative structure | What does thermodynamics explain about living order, and where does it stop? | Flagship 1 and future existence series |

### 6.2 Auxiliary notes grounded in the live drafts

These five candidates bring the field-note slate to fifteen without introducing disconnected topics.

| Working note | Precise question | Likely renderer | Feeds |
|---|---|---|---|
| Fourier and representation | What becomes simple or local when an image changes basis? | MathJax and static figures | Fourier draft and flagship 2 |
| Rao and distinguishability | Why does a probability family have a metric, and what is invariant? | MathJax | Information-theory draft |
| Dijkstra, A*, and representation | Which guarantees depend on having a graph, costs, and a heuristic? | MathJax and p5.js | Maze draft |
| Nakagaki and embodied search | What must be counted when a physical system appears to solve a maze? | Static figure or p5.js | Maze draft and flagship 4 |
| Phyllotactic failure cases | Which perturbations distinguish packing from developmental control? | p5.js | Pinecone draft and flagship 7 |

Only create these notes when they have a concrete source plan and a place in the network. Proposed titles are not publication commitments.

## 7. Simulation, notebook, and build-log portfolio

At least four public artifacts should be durable enough that another person can reproduce the central observation.

### Artifact A: reaction-diffusion regimes

- two-species model with equations and parameter definitions;
- fixed initial conditions and optional seeded noise;
- parameter sweep covering homogeneous, patterned, unstable, and failed regimes;
- perturbation experiments;
- downloadable data or notebook;
- static regime map;
- used by flagship 1.

### Artifact B: cellular automata and macroscopic observables

- several rules or rule families;
- reproducible initial conditions;
- observables such as density, entropy proxy, activity, periodicity, or structure count;
- clear warning that the chosen observable and coarse graining shape the conclusion;
- static comparison panels;
- used by flagship 4.

### Artifact C: search, memory, and embodied maze solving

- common maze instances;
- graph-search baseline;
- local or memory-limited agent;
- Physarum-inspired or field-based comparison;
- metrics for path quality, time, memory, robustness, and physical work assumptions;
- static results table;
- used by the Maze draft.

### Artifact D: phyllotaxis and perturbation

- angle, radial growth, noise, and boundary controls;
- ideal and perturbed arrangements;
- measures of packing or parastichy structure;
- failure regimes;
- used by flagship 7.

### Optional Artifact E: open-ended search

This is a preprint candidate only after a literature and baseline audit. It should compare objective search, novelty, quality diversity, or coevolution under a frozen protocol. Do not promise novelty before that audit.

Each artifact should have:

- a precise question;
- source code;
- environment or dependency specification;
- seed and parameter policy;
- data provenance;
- generated outputs;
- accessibility description;
- a static fallback;
- a license and citation path if placed in a separate repository;
- negative or failed cases;
- a short statement of what the artifact cannot establish.

## 8. Preprint funnel

The four-month goal is one defensible preprint, not journal acceptance. Venue selection happens only after the contribution exists and official policies have been rechecked.

Candidate directions:

1. A reproducible comparison of search objectives and open-ended exploration.
2. A methodological paper on distinguishing pattern reproduction from developmental explanation.
3. A rigorous position or survey paper if an empirical novelty claim does not survive the literature audit.

Before committing to an empirical paper, answer yes to all:

1. Can the claim be stated in one sentence without umbrella language?
2. Is the gap present in the primary literature?
3. Can a result disconfirm the claim?
4. Are baselines fair and reproducible?
5. Is the evaluation protocol fixed before results are interpreted?
6. Can all required code, data, figures, and methods be released?
7. Has NVIDIA confidentiality, ownership, disclosure, and publication review been handled where required?

Preprint stages:

```text
question
→ scoping search
→ literature and claim matrix
→ novelty audit
→ hypotheses and disconfirmation criteria
→ baseline reproduction
→ frozen protocol
→ experiments and negative results
→ interpretation with alternatives
→ internal reproducibility audit
→ employer/publication clearance
→ external review
→ archival artifact release
→ preprint
→ accessible blog synthesis
```

Evidence, code, and release dates must never be invented to fill a roadmap.

## 9. Research preprocessing in Obsidian

### 9.1 Capture

Configure Obsidian Web Clipper to save into:

```text
00 Inbox/Web Clips
```

A clip is an untrusted input. Preserve URL, title, author, publication date, and clipped date when available. Do not paste clipped prose directly into a public draft without verification and synthesis.

### 9.2 Triage

For each useful clip:

1. Identify the exact claim or question it may support.
2. Find the primary source when the clip is secondary.
3. Record whether the source is primary, review, textbook, reporting, commentary, or speculation.
4. Check publication details and stable links.
5. Note limitations, counterevidence, and possible conflicts.
6. Extract only short quotations needed for later verification.
7. Move durable evidence into `10 Sources`.
8. Move reusable synthesis into `20 Concepts`.
9. Delete, archive, or leave the raw clip in the inbox according to personal preference. It remains private either way.

### 9.3 Source notes

Create one source note per paper, book chapter, dataset, talk, or authoritative page when it will be used materially.

Recommended body:

```markdown
## Claim relevant to this project

## Evidence and method

## Variables, assumptions, and sample

## Limitations and counterevidence

## Quotations to verify

## Connections

## Citation
```

Every important claim should record:

- what the source directly establishes;
- what the author infers;
- what this project infers;
- what remains speculative;
- which result, figure, equation, or passage supports it.

Never manufacture a page number, DOI, quotation, result, or citation. Mark unknown fields as open.

### 9.4 Concept notes

Concept notes in `20 Concepts` are private synthesis. A useful concept note includes:

- a working definition;
- neighboring and competing definitions;
- an operational test;
- canonical examples;
- counterexamples;
- scale and observer dependence;
- related source notes;
- related article questions;
- unresolved tensions.

High-value concepts for this project include:

- computation;
- information;
- representation;
- agency;
- goal-directedness;
- emergence;
- selection;
- open-endedness;
- morphology;
- error correction;
- universality;
- explanation;
- implementation;
- agent boundary.

### 9.5 Literature and claim matrix

Before a flagship or paper-sized claim, maintain a matrix with:

| Claim or question | Supporting source | Opposing source | Evidence type | Assumptions | Confidence | Needed test |
|---|---|---|---|---|---|---|

This can be Markdown, CSV, or a notebook. Its function is to prevent a persuasive narrative from outrunning the evidence.

### 9.6 Create or select the draft

Search the vault before creating a note. If no appropriate draft exists:

```bash
bin/blog new "A precise working title"
```

This creates a private note in `30 Drafts` with:

```yaml
status: todo
math: false
p5: false
blog_publish: false
```

Keep a new article private until the user explicitly permits public export.

## 10. Front matter contract

Example:

```yaml
---
title: "Maze Solving as Search, Memory, and Embodied Computation"
slug: maze-solving
aliases:
  - Maze Solving
description: "A precise one-sentence description for readers and search."
date: 2025-03-02
updated: 2026-07-23
status: in-progress
content_type: explainer
tags:
  - algorithms
  - graph-search
  - embodied-computation
people:
  - Claude Shannon
  - Edsger Dijkstra
next_step: "Formalize the solver comparison and finish the interactive."
math: true
p5: true
blog_publish: false
---
```

Properties:

| Property | Meaning |
|---|---|
| `title` | Reader-facing article title |
| `slug` | Stable canonical URL identifier |
| `aliases` | Stable alternate names used for discovery and link normalization |
| `description` | One-sentence summary used in cards and metadata |
| `date` | Publication identity date in `YYYY-MM-DD` |
| `updated` | Date of material revision |
| `status` | `todo`, `in-progress`, or `published` |
| `content_type` | Usually `essay`, `explainer`, `field-note`, or `research-note` |
| `tags` | Controlled conceptual neighborhoods |
| `people` | Researchers substantively discussed |
| `next_step` | Concrete current action shown on the public board when exported |
| `math` | Loads MathJax when `true` |
| `p5` | Loads p5.js when `true` |
| `blog_publish` | Privacy boundary; only `true` can leave the vault |

Rules:

- Preserve an existing slug and date unless a deliberate migration is approved.
- Update `updated` for a material revision, not every typo.
- Use a small stable vocabulary for tags.
- Add a person only when the article materially engages their work.
- `next_step` should name an observable action.
- Renderer flags describe actual dependencies, not future aspirations.
- `status` does not provide privacy.

## 11. Drafting and editorial passes

Recommended initial anatomy:

```markdown
> **Claim:** State the narrow claim in one sentence.

## The anomaly

## The mechanism

## Where the connection works

## Where the connection breaks

## An experiment that could change my mind

## References
```

Adapt the structure when the subject needs it, but preserve the functions.

Use separate passes:

1. **Question pass:** Is there one answerable question?
2. **Mechanism pass:** Are states, processes, variables, and causal claims explicit?
3. **Evidence pass:** Does each important claim point to an appropriate source or result?
4. **Adversarial pass:** Is the strongest objection represented fairly?
5. **Connection pass:** Are cross-domain links exact, useful, and limited?
6. **Mathematics pass:** Are symbols defined, assumptions stated, and derivations checked?
7. **Experiment pass:** Can another person reproduce the result?
8. **Accessibility pass:** Do figures, controls, captions, and prose work without relying on color or motion?
9. **Narrative pass:** Does the opening earn the question and does each section move the argument?
10. **Metadata pass:** Do title, description, headings, and internal links describe the article honestly?
11. **Punctuation pass:** Remove every Unicode em dash.
12. **Publication pass:** Confirm confidentiality, employer obligations, and public state.

Do not use smooth prose to hide uncertainty. Useful labels include:

- Evidence:
- Inference:
- Speculation:
- Open question:
- Counterexample:
- What would change my mind:

## 12. Wikilinks and conceptual connectedness

Tags and wikilinks do different jobs:

- tags place articles in broad neighborhoods;
- wikilinks assert that one exact argument depends on, supports, contrasts with, limits, or extends another;
- backlinks reveal where a target is used;
- the Explore graph visualizes both shared taxonomy and explicit references, with explicit edges treated separately.

### 12.1 Supported syntax

```markdown
[[pinecone]]
[[pinecone|phyllotaxis]]
[[pinecone#Questions this note must answer]]
[[pinecone#Questions this note must answer|the unresolved developmental mechanism]]
```

Use the canonical filename as the destination. The visible label comes after `|`.

If a title or alias was used as the destination:

```bash
bin/blog normalize-links
```

The normalizer rewrites it to the canonical filename while preserving the visible text.

### 12.2 Link-writing standard

Place a wikilink in the sentence that uses the connected idea. Prefer an exact section when only one part of the target is relevant.

Weak:

```markdown
See also [[pinecone]].
```

Stronger:

```markdown
The visual regularity does not by itself identify the developmental cause, a
distinction developed in [[pinecone#Questions this note must answer|the
phyllotaxis failure cases]].
```

For each meaningful link, know its relation:

- supports;
- contrasts;
- supplies a mechanism;
- supplies a mathematical tool;
- transfers a test;
- exposes a limit;
- extends an open question.

The relation does not currently need special syntax. It must be clear from the surrounding prose.

### 12.3 Privacy and unresolved targets

An exported draft cannot link to a private note. This is deliberate.

When two connected notes are private, links may be used normally in Obsidian. Before exporting the source article:

- export the target too, after privacy review;
- replace the link with a stable external citation;
- explain the needed concept inside the article;
- or remove the premature link.

Do not create empty public pages merely to satisfy a planned connection.

### 12.4 Headings, aliases, and renames

- exact-section links must match a real Markdown heading;
- preserve old note names as aliases after a rename;
- update incoming section links when a heading changes;
- do not change a slug only to improve wording;
- run normalization and validation after renames.

### 12.5 Generated reader experience

At Jekyll build time:

- wikilinks become accessible ordinary links;
- exact sections become heading anchors;
- the source lists its outgoing references;
- the target lists automatic back references;
- the Explore graph draws an explicit reference edge;
- selecting a graph node lists reference direction and source or target sections.

This is the mechanism through which the notebook can reveal paths that tags alone cannot show.

## 13. Mathematics with MathJax

Set:

```yaml
math: true
```

The page then loads MathJax 4. Supported authoring forms include:

```markdown
Inline: $H(X) = -\sum_x p(x)\log p(x)$

Display:

$$
\frac{\partial u}{\partial t} = D_u\nabla^2 u + f(u,v).
$$
```

Math standards:

- define every symbol near first use;
- state domains, units, distributions, and assumptions;
- explain the intuition before or immediately after the formal statement;
- break long derivations into aligned conceptual steps;
- verify boundary conditions and sign conventions;
- number only equations that are referenced;
- provide prose meaning for important equations;
- never use an equation as visual authority when it does not advance the argument.

MathJax includes accessible exploration tools, but accessibility still depends on good prose and logical markup.

## 14. p5.js interactives

Set:

```yaml
p5: true
```

This loads p5.js 2.3.0 only on that page. A page without a sketch should keep `p5: false`.

Put a sketch script under a stable public path, for example:

```text
assets/js/sketches/maze-solvers.js
```

Embed it in the article:

```liquid
{% include p5-sketch.html
   id="maze-solvers"
   script="/assets/js/sketches/maze-solvers.js"
   alt="Comparison of graph search and a local maze solver"
   caption="Change the solver and seed, then compare path quality and explored area." %}
```

Use p5 instance mode. Attach the canvas to the include's container. Do not depend on a global `setup` or `draw` that can collide with another sketch.

Every interactive should provide:

- ordinary HTML controls or keyboard-accessible controls;
- labels and instructions;
- pause and reset for continuous motion;
- reduced-motion behavior;
- a deterministic seed when comparisons matter;
- parameter defaults that reproduce the article's example;
- a text explanation of what changes and what does not;
- a static fallback for feeds, printing, failures, and readers who cannot use the interactive;
- a statement of what the simulation demonstrates and what it does not.

Do not add motion as decoration. Interactivity should allow a reader to test a parameter, compare regimes, or discover a relation.

## 15. Manim and other animation

Manim is a build-time production tool, not a browser dependency.

Recommended flow:

1. Keep Manim source in the associated artifact project or a clearly named source directory.
2. Render WebM and MP4.
3. Create a poster image.
4. Create WebVTT captions if there is narration.
5. Include a transcript or nearby derivation.
6. Optimize media before committing.
7. Put large source renders in an archival release rather than the website repository.

Embed:

```liquid
{% include video-figure.html
   webm="/assets/media/example.webm"
   mp4="/assets/media/example.mp4"
   poster="/assets/media/example-poster.webp"
   captions="/assets/media/example.vtt"
   caption="A step-by-step construction of the update rule." %}
```

The include uses controls, metadata preload, inline playback, and an ordinary download fallback.

## 16. Bespoke interactives and attachments

For a self-contained HTML, CSS, and JavaScript experiment, use:

```text
assets/interactives/<slug>/
```

Embed it with:

```liquid
{% include interactive-figure.html
   src="/assets/interactives/example/index.html"
   title="Interactive title for assistive technology"
   height="680px"
   caption="What the reader can test." %}
```

The iframe is lazy-loaded and sandboxed.

Obsidian attachment syntax:

```markdown
![[diagram.png|Description of the diagram]]
![[results.csv|Download the result table]]
```

Supported image formats:

- AVIF, GIF, JPEG, JPG, PNG, SVG, WebP.

Supported downloads:

- CSV, JSON, PDF, TXT, ZIP.

During sync, the compiler finds the attachment, copies it to `assets/notes/<slug>/`, and rewrites the embed to ordinary Markdown. Missing, ambiguous, or unsupported attachments stop export. Note transclusion is rejected.

Static figures remain the default when interactivity does not materially improve understanding.

## 17. Deterministic preprocessing and compilation

The stable entry point is:

```bash
bin/blog
```

### 17.1 Status and normalization

```bash
bin/blog status
bin/blog normalize-links
```

`status` reads the vault and shows every draft by editorial stage and privacy state.

`normalize-links`:

- indexes note filenames, titles, slugs, and aliases;
- finds links outside fenced and inline code;
- converts title or alias destinations to canonical filenames;
- preserves reader-facing labels;
- refuses to proceed when names or aliases are ambiguous.

Normalization changes vault source notes. Review those changes before compiling.

### 17.2 Validation

```bash
bin/blog check
```

Validation:

1. reads `.obsidian-blog.yml`;
2. indexes Markdown notes in the vault;
3. selects drafts with `blog_publish: true`;
4. checks required front matter;
5. checks allowed statuses and ISO dates;
6. checks slug format and uniqueness;
7. rejects Unicode em dashes in exported body or metadata;
8. resolves wikilinks;
9. enforces canonical filename destinations;
10. validates exact target headings;
11. rejects public links to private notes;
12. rejects note transclusion;
13. resolves supported attachments;
14. rejects missing or ambiguous files.

The check does not publish or write generated posts.

### 17.3 Sync

```bash
bin/blog sync
```

Sync first runs validation, then:

1. selects only opted-in drafts;
2. rewrites supported attachment embeds;
3. copies selected files into `assets/notes/<slug>/`;
4. removes the private `blog_publish` property;
5. normalizes date and slug;
6. sets `sitemap: false` for unfinished work;
7. writes `_posts/YYYY-MM-DD-<slug>.md`;
8. adds `obsidian_source` and a SHA-256 source fingerprint;
9. refuses to overwrite an unmanaged post;
10. reports a managed orphan rather than deleting it.

Never hand-edit a generated `_posts` file carrying `obsidian_source`. Edit the vault source and sync again.

## 18. Jekyll post-processing

After sync, the Jekyll build performs public-site processing:

- Liquid includes are rendered;
- Markdown becomes HTML;
- strict wikilinks resolve to public URLs;
- exact target sections are validated again;
- outgoing reference data and automatic backlinks are generated;
- tags and explicit reference edges become Explore graph data;
- the public writing board groups generated posts by status;
- search data is generated;
- published articles enter the sitemap and feed;
- todo and in-progress work receives `noindex, follow` and remains out of the sitemap;
- canonical metadata, Open Graph data, BlogPosting JSON-LD, and breadcrumbs are created;
- MathJax and p5.js load only when the article opts in;
- GA4 loads only after reader consent;
- generated text is scanned for a forbidden Unicode em dash.

The result is still local until GitHub publication completes.

## 19. Review and local preview

Before Git:

```bash
git status --short --branch
bin/blog normalize-links
bin/blog check
bin/blog sync
docker compose up -d --build
docker compose ps
```

Preview:

```text
http://localhost:4000
```

Opening Docker Desktop alone does not start the site. Once the container is running, Jekyll watches repository files. Obsidian changes are invisible to it until another sync.

Inspect:

- title, description, author, status, and next step;
- equations at desktop and mobile widths;
- p5 controls, reset, deterministic examples, and static fallback;
- Manim video, poster, captions, and transcript;
- figure alt text and captions;
- wikilinks and exact heading jumps;
- outgoing references and back references;
- selected-node reference details on `/explore/`;
- the correct public board column on `/writing/`;
- absence of private source notes and unintended attachments;
- canonical URL, structured data, and social metadata;
- sitemap and noindex behavior;
- light and warm dark themes;
- no Unicode em dash.

Run the production-equivalent build:

```bash
docker compose exec -T -e JEKYLL_ENV=production site \
  bundle exec jekyll build --trace --destination /tmp/tummo-site
```

## 20. Publication through Codex and GitHub

Publication requires explicit user authorization.

The publishing workstream should:

1. read the canonical memory and this roadmap;
2. inspect Git and the current vault note;
3. review confidentiality and employer obligations;
4. review claims, citations, links, renderers, artifacts, and accessibility;
5. report blockers;
6. change `status` or `blog_publish` only when authorized;
7. normalize, validate, and sync;
8. inspect the generated diff and copied attachments;
9. rebuild and inspect Docker;
10. run the production build;
11. create an isolated `codex/<description>` branch;
12. stage only intended files;
13. commit and push;
14. open a draft pull request;
15. wait for checks;
16. move it to ready and merge after review;
17. wait for the Pages deployment;
18. verify the canonical page on `https://tummo.ai`;
19. verify the board, graph, backlinks, sitemap, feed, and HTTPS as relevant;
20. update `PROJECT_MEMORY.md` and this roadmap if publication or portfolio state changed.

Merging to `main` triggers production. A Docker rebuild or a push to a feature branch does not update the live blog.

## 21. Research-to-publishing handoff packet

A research chat should finish with a concise handoff containing:

```text
Article:
Canonical vault file:
Current privacy and status:
Question:
Narrow claim:
Evidence established:
Inference:
Speculation:
Open questions:
Primary sources added or verified:
Sources still missing:
Strongest objection:
Equations checked:
Artifact state:
Required renderer flags:
Static fallback:
Proposed public wikilinks:
Exact target sections:
Publication blockers:
Files changed:
Recommended next step:
```

This handoff does not replace the files. It helps the publishing workstream inspect the right current state.

The publishing chat should return:

```text
Source reviewed:
Privacy/status changes:
Normalization result:
Validation result:
Generated files:
Attachments copied:
Docker preview:
Production build:
Git branch and commit:
Pull request:
Checks:
Merge:
Pages deployment:
Live URL verification:
Memory/roadmap update:
Remaining issues:
```

## 22. Prompts for separate project chats

### Start research on one planned article

```text
Read AGENTS.md, docs/PROJECT_MEMORY.md, and
docs/BLOG_RESEARCH_ROADMAP.md in full. Work only on the article:
<ARTICLE OR FLAGSHIP>. Inspect the current Obsidian note before editing and use
the vault as the source of truth. Build a primary-source research map, separate
evidence from inference and speculation, identify the strongest objection,
check the planned math and artifact, and improve the current private draft.
Preserve blog_publish, status, slug, and date unless I explicitly ask to change
them. Do not sync, commit, push, open a pull request, or deploy. Finish with the
research-to-publishing handoff packet from the roadmap.
```

### Process captured research

```text
Read AGENTS.md, docs/PROJECT_MEMORY.md, and
docs/BLOG_RESEARCH_ROADMAP.md. Triage the relevant Web Clipper notes in
00 Inbox/Web Clips for <TOPIC>. Locate primary sources where needed, create or
improve private source notes in 10 Sources, update useful concept notes in
20 Concepts, and tell me which claims can responsibly enter the target draft.
Do not copy clipped prose into the article, invent citations, change public
state, sync, or use Git.
```

### Develop mathematics and an interactive

```text
Read the project memory, research roadmap, visualization guide, current draft,
and relevant artifact files. For <ARTICLE>, verify the derivation, define every
symbol and assumption, design the smallest useful p5.js or Manim visual, include
accessibility and a static fallback, and state what the visual can and cannot
show. Keep the draft private and do not publish.
```

### Editorial and reproducibility audit

```text
Read the canonical project files and the current Obsidian source for
<ARTICLE>. Audit claims, citations, objections, equations, simulation protocol,
seeds, parameters, data provenance, accessibility, SEO framing, and wikilinks.
List blockers first. Do not change publication state or deploy.
```

### Hand an article to this publishing workstream

```text
Read AGENTS.md, docs/PROJECT_MEMORY.md, and
docs/BLOG_RESEARCH_ROADMAP.md. Inspect 30 Drafts/<FILE>.md and the handoff from
the research chat. Prepare a publication-readiness report. If I have explicitly
authorized publication and no blocker remains, perform the complete validation,
sync, Docker, production build, GitHub pull request, merge, Pages verification,
and state-update workflow. Otherwise stop after local review and report the
exact next action.
```

## 23. Post-publication loop

Publishing is the start of a feedback cycle.

After a finished article is live:

1. verify the live page and structured metadata;
2. request Search Console indexing if appropriate;
3. share an audience-specific summary that links to the canonical article;
4. contact cited researchers only with a precise question or useful artifact;
5. monitor consented GA4 engagement, Search Console queries, backlinks, and substantive responses;
6. record corrections and new sources;
7. add wikilinks from later work when a real conceptual relation emerges;
8. update the article's `updated` date for material revisions;
9. publish a correction note when a change affects the argument;
10. feed unanswered questions into the next field note, experiment, or paper.

Optimize for:

- complete reading and onward navigation;
- earned references;
- use of simulations or notebooks;
- serious critique;
- research conversations;
- corrections that strengthen the work;
- ideas that become testable projects.

Do not optimize solely for page views, impressions, or keyword repetition.

## 24. State maintenance

Update this roadmap when:

- a planned flagship is created, renamed, merged with an existing draft, or dropped;
- a field note or artifact is committed to the calendar;
- article status or public privacy state changes;
- a renderer or artifact requirement changes;
- a major link between articles is added or removed;
- the paper candidate changes;
- the four-month schedule or target changes;
- an article or preprint is published.

For every update:

1. inspect the current vault and repository;
2. change **Last verified**;
3. distinguish current state from proposal;
4. preserve canonical filenames and aliases;
5. update `PROJECT_MEMORY.md` when the change also affects operational state;
6. never put private research content or credentials into this public repository document.

### Change log

- **2026-07-23:** Created the shared research and article roadmap. Recorded the five live drafts, eight flagship dossiers, fifteen field-note candidates, artifact and preprint funnels, the complete Obsidian-to-GitHub workflow, renderer contracts, cross-chat handoffs, and reusable prompts.

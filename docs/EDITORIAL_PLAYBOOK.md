# Editorial, research, and distribution playbook

## The promise to the reader

Every published essay should do at least one of these:

- make a subtle mechanism visually or mathematically clear;
- connect two literatures and show exactly where the analogy holds or breaks;
- produce a new experiment, dataset, taxonomy, or falsifiable conjecture;
- correct an attractive but misleading popular story.

A biography of Turing, Shannon, von Neumann, Conway, Levin, or Penrose is not enough. The scientist is an entrance into a live problem, not the product.

## Content types

| Type | Scope | Evidence bar | Typical length |
|---|---|---|---:|
| Field note | One observation or mechanism | Primary source + concrete example | 500–900 words |
| Explainer | A difficult idea rebuilt carefully | Derivation or runnable demonstration | 1,500–2,500 words |
| Flagship essay | An original bridge or argument | Primary literature, objections, original visual | 2,500–4,000 words |
| Experiment report | A claim tested in public | Code, environment, baselines, negative results | As needed |
| Paper companion | Accessible route into a preprint | Stable paper and artifact links | 1,500–2,500 words |

## Article anatomy

1. **The anomaly:** a concrete observation that earns the question.
2. **The naive story:** what a smart newcomer might reasonably believe.
3. **The mechanism:** definitions, dynamics, equations, and evidence.
4. **The bridge:** a second domain where the mechanism might transfer.
5. **The break:** where the analogy stops being valid.
6. **The experiment:** what could discriminate among explanations.
7. **The residual:** unanswered questions and links to the next nodes.

## Publication gate

An article changes from `status: seed` to `status: published` only when:

- [ ] the opening states a specific question, tension, or claim;
- [ ] important factual claims cite primary or authoritative sources;
- [ ] evidence, inference, and speculation are labeled distinctly;
- [ ] at least one strong objection is represented fairly;
- [ ] the piece contains an original figure, derivation, simulation, or conceptual table;
- [ ] all code and data links run from a clean environment;
- [ ] the title and description are concrete and non-hyperbolic;
- [ ] images have useful alt text and sources/rights are documented;
- [ ] three to six canonical concept tags are used;
- [ ] at least three internal links create an onward reading path;
- [ ] employer confidentiality, disclosure, and review obligations are satisfied;
- [ ] `sitemap: false` is removed and `updated:` is accurate.

## Canonical vocabulary

Use a small stable ontology. Prefer these over synonyms:

- artificial-life
- cellular-automata
- complex-adaptive-systems
- emergence
- evolution
- evolutionary-computation
- information-theory
- mathematical-physics
- morphogenesis
- nature-inspired-computing
- social-systems
- theory-of-mind

People belong in `people`, not in `tags`. Series belong in `series`. Article maturity belongs in `status`.

## The distribution loop

### Seven days before publication

- Extract one sentence the target reader will disagree with or remember.
- Prepare one diagram that works without the article.
- Send the draft to one mechanism expert and one intelligent outsider.
- Identify three communities where the artifact genuinely answers an existing question.

### Launch day

- Publish the canonical article and RSS entry first.
- Send a short email with the problem, one insight, and the link.
- Adapt the idea into a native LinkedIn post and an X/Bluesky thread; do not paste the article.
- Share to Hacker News, Lobsters, or a specialist subreddit only when the artifact matches the community and the framing is transparent.
- Email cited researchers only with a precise reason the work may interest them.

### The next 72 hours

- Answer substantive questions quickly and amend real errors.
- Turn the best objection into a visible note or follow-up experiment.
- Record which headline, diagram, and community produced engaged reading rather than clicks.

### Thirty days later

- Review Search Console queries and improve mismatched titles or introductions.
- Add links from newer work and update the concept graph.
- Ask whether the essay earned backlinks, conversations, code use, or research progress.
- Refresh the article if the answer improved; do not silently change the central claim.

## Measurement

Track a compact weekly table:

- search impressions, organic clicks, and indexed pages;
- engaged sessions and readers reaching 75% depth;
- RSS/email growth and click-through;
- referring domains and which page earned them;
- substantive comments, corrections, and researcher replies;
- artifact clones, stars, forks, citations, and reproductions;
- hours spent per piece and which steps caused delay.

Analytics must be privacy-conscious and should not be added until a provider is chosen. Search Console is the first measurement tool because it directly reveals indexation and query intent.

## Research release checklist

- [ ] one-sentence contribution and explicit non-contributions;
- [ ] literature search log and related-work matrix;
- [ ] hypotheses or evaluation questions frozen before final runs;
- [ ] baselines, ablations, seeds, and uncertainty reported;
- [ ] code license, data license, and provenance documented;
- [ ] environment lockfile and one-command reproduction path;
- [ ] negative and null results retained;
- [ ] archival identifier for the release when appropriate;
- [ ] ORCID and consistent author name on paper, code, and site;
- [ ] NVIDIA disclosure/approval completed when applicable;
- [ ] venue selected for contribution fit; current policies and calls verified on the official venue site.


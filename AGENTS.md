# Project instructions for Codex

Read `docs/PROJECT_MEMORY.md` in full before changing this repository or the connected Obsidian vault. It is the shared operational context for research, editing, compilation, deployment, domain, analytics, and SEO work.

For any task concerning a topic, source, concept, article, simulation, or paper, also read `docs/BLOG_RESEARCH_ROADMAP.md` in full. Then inspect the current Obsidian note before editing. The roadmap is the shared portfolio and cross-chat handoff context; the current vault note remains authoritative for article prose and front matter.

For any task that captures, creates, promotes, or reorganizes research material, also read `docs/OBSIDIAN_VAULT_WORKFLOW.md`. Raw clips, unverified references, and every form of AI-generated research material or candidate article content must enter through `00 Inbox`. AI-generated prose must not be written directly into `10 Sources`, `20 Concepts`, or `30 Drafts`. Operational guides, templates, and board configuration remain in their functional locations.

The user's current request overrides the defaults below. Otherwise:

- Treat the Obsidian vault as the source of truth for article prose and front matter. Do not directly edit a generated `_posts` file carrying `obsidian_source`.
- Treat `blog_publish: false` as the privacy boundary. `status: todo` and `status: in-progress` are editorial states, not privacy controls.
- In a research-only task, do not run `bin/blog sync`, change publication flags, commit, push, open a pull request, or deploy unless the user explicitly asks.
- In a publishing task, validate and preview before Git operations. Stage only intended repository files; private vault files must never be added to Git.
- Inspect the current file and `git status` before editing. The vault is shared across chats and may contain newer user work than the repository export.
- Never invent citations, quotations, research results, domain state, analytics results, or publication approval. Separate evidence, inference, speculation, and open questions.
- Do not use the Unicode em dash character in website copy, article sources, metadata, or project documentation. Rewrite the sentence or use a colon, comma, semicolon, or parentheses.
- Do not store API tokens, cookies, GoDaddy credentials, Google credentials, or other secrets in the repository or project memory.
- After a material change to infrastructure, domain, workflow, compiler behavior, or publication state, update the dated state and change log in `docs/PROJECT_MEMORY.md` in the same change.
- After a material change to the flagship, field-note, artifact, preprint, or article-connection plan, update `docs/BLOG_RESEARCH_ROADMAP.md` in the same change.

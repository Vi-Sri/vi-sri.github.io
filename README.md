# Srinivas Venkatanarayanan — connected research notebook

The source for [vi-sri.github.io](https://vi-sri.github.io): essays, field notes, simulations, and research connecting computation, evolution, morphogenesis, artificial intelligence, complex adaptive systems, and mathematical physics.

## What this repository contains

- A Jekyll site hosted on GitHub Pages
- Search and an interactive concept graph without an external database
- Obsidian-style wikilinks, section links, automatic backlinks, and explicit-reference graph edges
- Structured article metadata, an XML sitemap, and an RSS feed
- A public Todo → In progress → Published writing board that keeps unfinished notes visible but out of search indexes
- A [four-month revival plan](docs/FOUR_MONTH_REVIVAL_PLAN.md)
- An [editorial and research playbook](docs/EDITORIAL_PLAYBOOK.md)

## Local development

Use Ruby 3.3.4, matching the GitHub Pages runtime configured for this repository.

```bash
bundle install
bundle exec jekyll serve --livereload
```

Then visit `http://127.0.0.1:4000`.

### Docker live preview

```bash
docker compose up --build
```

Visit `http://localhost:4000`. While the container is running, Jekyll watches the mounted repository and rebuilds when a site file changes. Merely opening Docker Desktop does not start this watcher.

## Search, analytics, math, and visualization

- Follow [Search and measurement setup](docs/SEARCH_AND_MEASUREMENT_SETUP.md) after creating the Google properties.
- Use [Mathematics and visualization guide](docs/VISUALIZATION_GUIDE.md) for MathJax, p5.js, Manim, and sandboxed interactive figures.
- Use [Wikilinks and backlinks](docs/WIKILINKS.md) to connect notes and exact sections.
- Use [Obsidian publishing](docs/OBSIDIAN_PUBLISHING.md) for the private research → validated blog workflow.

## Publish a piece

1. Copy `_drafts/_article-template.md` and replace the placeholder front matter.
2. Start with `status: todo` and `sitemap: false`; move it to `status: in-progress` when research or experiments begin.
3. Keep `next_step` current and satisfy the evidence, visual, reproducibility, and distribution checks in `docs/EDITORIAL_PLAYBOOK.md`.
4. Move the file to `_posts/YYYY-MM-DD-slug.md`, set `status: published`, and remove `sitemap: false`.
5. Open a pull request and let the site build check run before merging.

The views and writing in this repository are personal and do not represent NVIDIA or any other employer.

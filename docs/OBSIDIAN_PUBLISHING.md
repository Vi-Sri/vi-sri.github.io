# Obsidian → blog publishing system

Obsidian is the private source of truth for research and drafting. GitHub contains only notes explicitly opted into the public blog. The compiler never scans Web Clipper captures, sources, or private concept notes into the repository.

## One-time setup

The local `.obsidian-blog.yml` points to the vault and is intentionally ignored by Git. Initialize and import the current blog:

```bash
bin/blog init
bin/blog import
bin/blog check
bin/blog sync --adopt
```

`--adopt` is needed only once because the original Jekyll posts predate the Obsidian provenance marker.

## Create and write

```bash
bin/blog new "A precise working title"
```

The note starts private with `blog_publish: false`. Write in Obsidian normally. Prefer selecting links from Obsidian's autocomplete so the destination is the note filename. The following all remain native Obsidian links and compile for the site:

```markdown
[[another-draft]]
[[another-draft#Exact heading]]
[[another-draft#Exact heading|the reader-facing connection]]
[[information-theory|Statistical Manifolds]]
![[diagram.png|A useful description]]
```

Obsidian aliases are reader-facing labels, not alternate destinations: use `[[canonical-filename|Alias]]`. If you type a title or alias as the destination, `bin/blog normalize-links` converts it without changing the visible text. The compiler resolves draft titles, filenames, slugs, and `aliases` during that normalization. Images and allowed downloads are copied into a slug-specific public asset directory. Note transclusion is rejected to prevent accidental publication of private material.

## Properties that control publishing

- `blog_publish`: the privacy boundary. Only `true` leaves the vault.
- `status`: `todo`, `in-progress`, or `published`.
- `title`, `slug`, `description`, `date`, `content_type`: required for exported notes.
- `tags`, `people`, `aliases`: taxonomy and link resolution.
- `next_step`: displayed on the public roadmap.
- `math`, `p5`: opt-in page renderers.

Todo and in-progress notes remain `noindex` and outside the sitemap. A published note becomes indexable after the existing editorial gate is satisfied.

## Validate and compile

```bash
bin/blog status
bin/blog normalize-links
bin/blog check
bin/blog sync
docker compose up -d --build
```

Validation rejects unresolved or noncanonical wikilinks, missing target sections, links from public drafts to private notes, duplicate public slugs, missing metadata, missing attachments, and private note transclusions. Generated posts carry their Obsidian source path and SHA-256 fingerprint.

The compiler does not commit or publish automatically. Review the local preview, then use the normal pull-request and GitHub Pages workflow.

## Obsidian CLI

Obsidian CLI requires the desktop app to be running. With Obsidian open:

```bash
bin/blog vault-audit
obsidian vault="Personal-notes" unresolved verbose
obsidian vault="Personal-notes" backlinks file="pinecone"
obsidian vault="Personal-notes" outline file="pinecone" format=tree
```

The filesystem compiler remains independent of the app, so `check` and `sync` are deterministic even when Obsidian is closed.

## Web Clipper

Configure the Chrome Web Clipper destination as `00 Inbox/Web Clips`. Captures are research inputs, not draft content. Distill reliable claims and citations into `10 Sources`, then write the argument in `30 Drafts`. This keeps clipped prose, uncertain claims, and private annotations outside the public export boundary.

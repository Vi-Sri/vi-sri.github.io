# Wikilinks and backlinks

Wikilinks encode deliberate relationships inside the prose. They are different from tags: tags place notes in broad conceptual neighborhoods, while a wikilink records that one specific argument or section depends on, contrasts with, or extends another.

## Syntax

```markdown
[[Pinecones]]
[[Pinecones#Questions this note must answer]]
[[Pinecones#Questions this note must answer|the unresolved mechanics]]
```

Targets resolve by exact title, URL slug, or an `aliases` entry in front matter. Section fragments are generated from Markdown headings. Wikilinks inside fenced code blocks or inline code are left unchanged. Prefix a literal wikilink with a backslash when it should appear as prose rather than become a link.

```markdown
\[[This remains literal]]
```

## Front-matter aliases

Long titles should have a small set of stable aliases:

```yaml
title: "Pinecones, Phyllotaxis, and the Computation of Form"
aliases: [Pinecones, Phyllotaxis]
```

Aliases are authoring conveniences. The generated link always points to the canonical URL.

## Generated behavior

- The wikilink becomes a normal accessible HTML link.
- A section reference jumps to that heading.
- The target note automatically lists the source under **Back references**.
- The source note lists its outgoing references in the metadata rail.
- The Explore graph draws a gold dashed edge for explicit references.
- Selecting a graph node lists the direction and source/target sections for each reference.
- Shared-tag edges remain separate, so deliberate references are not confused with taxonomy.

## Validation

Strict validation is enabled in `_config.yml`. A build fails when a note or requested section cannot be resolved. This prevents a rename from silently creating broken conceptual links.

When renaming a note, preserve its old authoring name in `aliases`. When renaming a heading, update incoming section wikilinks in the same change.

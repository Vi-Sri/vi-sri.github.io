# Search and measurement setup

The repository already generates canonical URLs, article metadata, author metadata, Open Graph previews, `robots.txt`, `sitemap.xml`, and `feed.xml`. The remaining Google steps require identifiers created inside the site owner's Google account.

## Google Search Console

1. Open Google Search Console and add the URL-prefix property `https://tummo.ai/`.
2. Choose **HTML tag** verification.
3. Copy only the value inside `content="…"` from the verification tag.
4. Put that value in `_config.yml` as `google_site_verification`.
5. Publish the site, verify the property, then submit `https://tummo.ai/sitemap.xml`.
6. Inspect `/`, `/about/`, `/research/`, and each finished essay. Todo and in-progress notes intentionally use `noindex` and do not appear in the sitemap.

The verification value is public by design and may be committed. Never commit Google account credentials or API secrets.

## Google Analytics 4

1. Create one GA4 property for the notebook.
2. Add a web data stream for `https://tummo.ai`.
3. The GA4 Measurement ID `G-6VQSSQG4PY` is configured in `_config.yml` as `google_analytics`.
4. Publish and accept analytics in the site banner during a test visit.
5. Confirm the visit in GA4 Realtime.

The site uses basic opt-in consent: it does not request the Google tag or write the analytics preference until the reader accepts. Advertising signals and ad personalization signals are disabled.

## Events available after GA4 is configured

- standard page views;
- internal searches in the writing archive and concept graph;
- selected search results;
- concept-graph node selections;
- article selections from the graph.

Add newsletter signup, code-repository, paper-download, and citation-copy events only when those features exist. Do not create vanity events that have no editorial decision attached.

## Weekly SEO review

- indexed versus excluded pages;
- queries with impressions but poor click-through;
- pages ranking between positions 5 and 20 that deserve stronger content;
- crawl or structured-data errors;
- referring domains and links earned by specific artifacts;
- engaged reading and onward navigation, not raw traffic alone.

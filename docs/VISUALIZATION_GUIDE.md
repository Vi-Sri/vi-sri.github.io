# Mathematics and visualization guide

The site uses the lightest renderer that fits the explanation. Libraries are opt-in per article so a prose essay never pays for an animation framework it does not use.

## MathJax 4: equations and mathematical accessibility

Set `math: true` in front matter. The page then loads the combined TeX/MathML-to-CommonHTML component, including MathJax's expression explorer and accessibility tools.

Use `$…$` for inline mathematics and `$$…$$` or `\[…\]` for display mathematics. Prefer semantic notation and define every symbol in prose. Very long derivations should be broken into aligned steps rather than forced into one horizontally scrolling expression.

## p5.js 2: live computational intuition

Set `p5: true` only on a page that has a sketch. Use p5 instance mode and attach the canvas to the container supplied by `p5-sketch.html`. Good uses include cellular automata, reaction–diffusion systems, particle models, evolutionary search, random walks, and phase-space intuition.

Every sketch must include:

- keyboard-accessible controls or ordinary HTML form controls;
- a pause/reset control when motion is continuous;
- a text description of the phenomenon;
- deterministic seeding when reproducibility matters;
- a static fallback figure for printing, feeds, search, and reduced-motion readers.

Do not use p5 merely to animate decoration.

## Manim: authored mathematical animation

Manim is a build-time renderer, not a browser dependency. Keep scene source beside the associated research artifact, render WebM and MP4 outputs, create a poster frame, and embed them with `video-figure.html`.

Prefer `preload="metadata"`, no autoplay, captions for narration, and a nearby transcript or derivation. Commit short optimized media only; archive large source renders in a release or research repository.

## Sandboxed interactive figures

For a bespoke simulation that needs its own HTML, CSS, and JavaScript, place it under `assets/interactives/<slug>/` and embed it with `interactive-figure.html`. The iframe is lazy-loaded and sandboxed. Use this for a self-contained experiment, not for ordinary charts.

## Static figures remain the default

For plots, diagrams, and experiment results, a well-labelled PNG/WebP plus data/code link is often faster, more accessible, easier to cite, and more durable than an interactive. Interactivity must let the reader test a parameter, compare regimes, or discover a relationship that a static figure cannot show.

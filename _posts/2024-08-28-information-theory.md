---
title: 'Statistical Manifolds: What Kind of Space Is a Model?'
description: A route from probability distributions to information geometry—and from
  representing a world to learning within it.
tags:
- information-geometry
- information-theory
- learning
- mathematical-physics
people:
- Claude Shannon
- C. R. Rao
aliases:
- Statistical Manifolds
- Information Theory
category: boc
content_type: explainer
status: in-progress
next_step: Write the Fisher metric derivation and test the invariance examples.
math: true
sitemap: false
related:
- fourier-transforms-and-images
slug: information-theory
date: '2024-08-28'
obsidian_source: 30 Drafts/information-theory.md
obsidian_sha256: 886b21868b1af54aa77f065867ec032e9db8d2eab9e99a84c21410ee8a4ba9e4
---

<!-- Generated from Obsidian: 30 Drafts/information-theory.md. Edit the vault source, then run bin/blog sync. -->

# Statistical manifolds

Machine-learning models do not merely occupy parameter space. They induce families of probability distributions with geometry of their own. This note asks what that geometry buys us—and when the word “manifold” clarifies rather than decorates an argument.

## Questions this note must answer

- How does the Fisher information metric arise from distinguishability?
- Which properties are invariant under reparameterization?
- What is the precise relationship between statistical and learned representation manifolds?
- Can information geometry explain any empirical behavior that ordinary optimization language cannot?

This working outline is growing into a worked essay with derivations, counterexamples, and reproducible visualizations.

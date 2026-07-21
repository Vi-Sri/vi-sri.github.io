---
title: 'Fourier Transforms: Sailing Through Latent Seas'
description: A visual primer on Fourier series and transforms, with connections to
  representation learning and the geometry of images.
tags:
- algorithms
- fourier-transform
- representation
- mathematical-physics
people:
- Joseph Fourier
aliases:
- Fourier Transforms
- Fourier
category: boc
content_type: explainer
status: todo
next_step: Design the image-domain experiments and assemble primary references.
math: true
sitemap: false
related:
- information-theory
slug: fourier-transforms-and-images
date: '2024-03-27'
obsidian_source: 30 Drafts/fourier-transforms-and-images.md
obsidian_sha256: 7bbb3852e8b313e4a0807218cfe736257662a076a450fe0dd9143f806dd4f689
---

<!-- Generated from Obsidian: 30 Drafts/fourier-transforms-and-images.md. Edit the vault source, then run bin/blog sync. -->

# Fourier series and transforms: a primer

A no-nonsense introduction to Fourier series and transforms, followed by a more interesting question: why do frequency coordinates repeatedly become useful representations for learning systems?

The deeper issue is geometric: a representation changes which differences appear locally meaningful. That question continues in [[information-theory#Questions this note must answer|the geometry of statistical distinguishability]].

## Questions this note must answer

- What changes—and what does not—when a signal moves from space or time into frequency?
- Why are locality and sparsity represented differently in the two domains?
- What exactly do convolutional models inherit from the Fourier view of translation?
- Where does the analogy between Fourier bases and learned latent spaces break?

This queued outline will become a visual essay with executable image experiments, derivations, and primary references.

---
title: Maze Solving as Search, Memory, and Embodied Computation
slug: maze-solving
aliases:
- Maze Solving
- Embodied Maze Solving
- Mazes as Computation
description: 'From graph search and information limits to slime molds and physical
  computation: what changes when a maze solver is an algorithm, an embodied agent,
  or a distributed dynamical system?'
date: '2025-03-02'
updated: 2026-07-21
status: in-progress
content_type: explainer
tags:
- algorithms
- graph-search
- pathfinding
- embodied-computation
- unconventional-computing
- nature-inspired-computing
- complex-adaptive-systems
people:
- Claude Shannon
- Edsger Dijkstra
- Peter Hart
- Nils Nilsson
- Bertram Raphael
- Toshiyuki Nakagaki
next_step: Formalize the solver comparison and build reproducible p5.js visualizations
  for graph search, local navigation, and a Physarum-inspired embodied solver.
math: true
p5: true
category: bob
related:
- pinecone
sitemap: false
obsidian_source: 30 Drafts/maze-solving.md
obsidian_sha256: d3f1981c6e69ed0160a56c80f297c016af92776c0727177c12345c1987479b3f
---

<!-- Generated from Obsidian: 30 Drafts/maze-solving.md. Edit the vault source, then run bin/blog sync. -->

# What is a maze?

A maze can be formalized as a graph, but physical solvers do not receive a graph. They encounter walls, gradients, costs, and partial observations. This note uses that gap to compare classical search with embodied and nature-inspired computation.

The same distinction between a pattern and the process producing it appears in [[pinecone#Questions this note must answer|the pinecone inquiry]], where local growth performs work that a global geometric description leaves unexplained.

## Questions this note must answer

- Which maze-solving algorithms require a global representation?
- How do memory constraints change completeness and optimality?
- In what sense do slime molds or reaction–diffusion systems “solve” a maze?
- What do physical solvers compute for free through their dynamics?

The finished version will include visual algorithm traces and a small reproducible benchmark.

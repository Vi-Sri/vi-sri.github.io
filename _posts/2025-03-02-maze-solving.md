---
title: "Maze Solving as Search, Memory, and Embodied Computation"
description: "From graph search to slime molds: what changes when a maze solver is an algorithm, a body, or a distributed physical process?"
tags: [algorithms, search, embodied-computation, nature-inspired-computing]
people: [Edsger Dijkstra]
category: bob
content_type: explainer
status: in-progress
next_step: "Build comparable algorithmic and embodied solver visualizations."
sitemap: false
related: [pinecone]
---

# What is a maze?

A maze can be formalized as a graph, but physical solvers do not receive a graph. They encounter walls, gradients, costs, and partial observations. This note uses that gap to compare classical search with embodied and nature-inspired computation.

## Questions this note must answer

- Which maze-solving algorithms require a global representation?
- How do memory constraints change completeness and optimality?
- In what sense do slime molds or reaction–diffusion systems “solve” a maze?
- What do physical solvers compute for free through their dynamics?

The finished version will include visual algorithm traces and a small reproducible benchmark.

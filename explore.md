---
layout: page
title: Explore the concept graph
kicker: Ideas are paths, not folders
description: "Search across the notebook or follow the shared concepts that connect one piece of writing to another."
permalink: /explore/
---
<div class="explore-search">
  <label class="search-field">
    <span class="sr-only">Search the concept graph</span>
    <input type="search" data-explore-search placeholder="Search concepts, titles, or people" autocomplete="off">
  </label>
  <p>Large nodes are concepts; small nodes are pieces of writing. Select a node to isolate its neighborhood.</p>
</div>

<div class="graph-panel">
  <div class="graph-toolbar">
    <p><strong data-graph-count>Loading the constellation…</strong></p>
    <button type="button" class="filter-chip" data-graph-reset>Reset view</button>
  </div>
  <canvas class="concept-graph" data-concept-graph aria-label="Interactive graph connecting writing through shared concepts"></canvas>
</div>

<noscript><p class="callout">The interactive graph needs JavaScript. Every topic and article remains available in the lists below.</p></noscript>

## Conceptual entrances

<div class="topic-list">
  {% for topic in site.data.topics %}
    <article id="{{ topic.slug }}" data-explore-item data-search="{{ topic.name | downcase }} {{ topic.question | downcase }} {{ topic.bridge | downcase }}">
      <span>0{{ forloop.index }}</span>
      <div><h3>{{ topic.name }}</h3><p>{{ topic.question }}</p><small>{{ topic.bridge }}</small></div>
    </article>
  {% endfor %}
</div>

## Every connected note

<div class="compact-writing-list">
  {% for post in site.posts %}
    <a href="{{ post.url | relative_url }}" data-explore-item data-search="{{ post.title | downcase }} {{ post.description | downcase }} {{ post.tags | join: ' ' | downcase }} {{ post.people | join: ' ' | downcase }}">
      <span>{{ post.date | date: '%Y' }}</span>
      <strong>{{ post.title }}</strong>
      <small>{{ post.tags | join: ' · ' }}</small>
    </a>
  {% endfor %}
</div>

<script id="graph-data" type="application/json">
{
  "posts": [
    {% for post in site.posts %}{
      "id": {{ post.slug | jsonify }},
      "title": {{ post.title | jsonify }},
      "url": {{ post.url | relative_url | jsonify }},
      "tags": {{ post.tags | jsonify }},
      "people": {{ post.people | default: empty | jsonify }}
    }{% unless forloop.last %},{% endunless %}{% endfor %}
  ]
}
</script>


---
layout: page
title: Explore the connected notes
kicker: Connections backed by actual writing
description: "Select a note to see the concepts it genuinely shares with other work in the notebook."
permalink: /explore/
---
<div class="explore-search">
  <label class="search-field">
    <span class="sr-only">Search the connected notes</span>
    <input type="search" data-explore-search placeholder="Search notes, concepts, or people" autocomplete="off">
  </label>
  <p>Every node is a real note. A line appears only when two notes share a named concept. Select a node for its summary and connections.</p>
</div>

<div class="graph-panel">
  <div class="graph-toolbar">
    <div class="graph-legend" aria-label="Graph legend"><span class="legend-dot legend-active"></span> In progress <span class="legend-dot legend-todo"></span> Todo <span class="legend-line"></span> Shared concept</div>
    <p><strong data-graph-count>Loading the notes…</strong></p>
    <button type="button" class="filter-chip" data-graph-reset>Reset selection</button>
  </div>
  <div class="graph-stage">
    <canvas class="concept-graph" data-concept-graph aria-label="Graph connecting actual notes through shared concepts"></canvas>
    <aside class="graph-detail" data-graph-detail aria-live="polite">
      <p class="eyebrow">How to read this</p>
      <h2>Select a note</h2>
      <p>The selected note becomes the visual focus. Its direct connections remain bright, and each connecting line names the shared concept.</p>
    </aside>
  </div>
</div>

<noscript><p class="callout">The visual graph needs JavaScript. Every path and note remains available in the linked lists below.</p></noscript>

## Research paths

<p>These are not abstract categories. Each path below links to the notes currently carrying that inquiry.</p>

<div class="topic-list">
  {% for topic in site.data.topics %}
    <article id="{{ topic.slug }}" data-explore-item data-search="{{ topic.name | downcase }} {{ topic.question | downcase }} {{ topic.bridge | downcase }} {{ topic.posts | join: ' ' | downcase }}">
      <span>0{{ forloop.index }}</span>
      <div>
        <h3>{{ topic.name }}</h3><p>{{ topic.question }}</p><small>{{ topic.bridge }}</small>
        <div class="topic-note-links">
          {% for post_slug in topic.posts %}{% for post in site.posts %}{% if post.slug == post_slug %}<a href="{{ post.url | relative_url }}">{{ post.title }} <span>→</span></a>{% endif %}{% endfor %}{% endfor %}
        </div>
      </div>
    </article>
  {% endfor %}
</div>

## Every note in the graph

<div class="compact-writing-list">
  {% for post in site.posts %}
    <a id="note-{{ post.slug }}" href="{{ post.url | relative_url }}" data-explore-item data-search="{{ post.title | downcase }} {{ post.description | downcase }} {{ post.tags | join: ' ' | downcase }} {{ post.people | join: ' ' | downcase }}">
      <span>{{ post.status | replace: '-', ' ' }}</span>
      <strong>{{ post.title }}</strong>
      <small>{{ post.tags | join: ' · ' }}</small>
    </a>
  {% endfor %}
</div>

{% include suggestion-cta.html %}

<script id="graph-data" type="application/json">
{
  "posts": [
    {% for post in site.posts %}{
      "id": {{ post.slug | jsonify }},
      "title": {{ post.title | jsonify }},
      "description": {{ post.description | jsonify }},
      "status": {{ post.status | default: 'todo' | jsonify }},
      "contentType": {{ post.content_type | default: 'essay' | jsonify }},
      "url": {{ post.url | relative_url | jsonify }},
      "tags": {{ post.tags | jsonify }},
      "people": {{ post.people | default: empty | jsonify }}
    }{% unless forloop.last %},{% endunless %}{% endfor %}
  ]
}
</script>

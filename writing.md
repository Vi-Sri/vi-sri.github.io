---
layout: page
title: Writing
kicker: Essays, field notes, and research seeds
description: "Long-form arguments, compact observations, and works in progress—organized by the questions they touch."
permalink: /writing/
---
<div class="archive-tools">
  <label class="search-field archive-search">
    <span class="sr-only">Filter writing</span>
    <input type="search" data-archive-search placeholder="Filter by title, concept, or person">
  </label>
  <div class="filter-row" role="group" aria-label="Filter by status">
    <button type="button" class="filter-chip is-active" data-filter="all">All</button>
    <button type="button" class="filter-chip" data-filter="published">Published</button>
    <button type="button" class="filter-chip" data-filter="seed">Research seeds</button>
  </div>
</div>

<div class="archive-list" data-archive-list>
  {% for post in site.posts %}
    <article class="archive-item" data-status="{{ post.status | default: 'published' }}" data-search="{{ post.title | downcase }} {{ post.description | downcase }} {{ post.tags | join: ' ' | downcase }} {{ post.people | join: ' ' | downcase }}">
      <div class="archive-date"><time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: '%Y' }}<br>{{ post.date | date: '%b %-d' }}</time></div>
      <div>
        <div class="writing-meta"><span>{{ post.content_type | default: 'essay' }}</span><span>{{ post.status | default: 'published' }}</span></div>
        <h2><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
        <p>{{ post.description }}</p>
        <div class="writing-tags">{% for tag in post.tags %}<span>{{ tag | replace: '-', ' ' }}</span>{% endfor %}</div>
      </div>
    </article>
  {% endfor %}
</div>
<p class="empty-state" data-archive-empty hidden>No writing matches that combination yet.</p>


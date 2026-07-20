---
layout: page
title: Writing roadmap
kicker: A read-only editorial board
description: "See what is queued, actively being developed, and ready to read. Nothing is presented as finished before it earns that status."
permalink: /writing/
---
{% assign todo_posts = site.posts | where: 'status', 'todo' %}
{% assign active_posts = site.posts | where: 'status', 'in-progress' %}
{% assign published_posts = site.posts | where: 'status', 'published' %}

<div class="roadmap-intro">
  <p>This is the public view of my writing queue. <strong>Todo</strong> means the question is scoped, <strong>in progress</strong> means research or experiments are underway, and <strong>published</strong> means the piece has passed the evidence and editorial bar.</p>
  <p class="roadmap-summary"><span>{{ todo_posts.size }} queued</span><span>{{ active_posts.size }} active</span><span>{{ published_posts.size }} published</span></p>
</div>

<div class="archive-tools">
  <label class="search-field archive-search">
    <span class="sr-only">Filter the writing roadmap</span>
    <input type="search" data-archive-search placeholder="Filter by title, concept, or person">
  </label>
  <div class="filter-row" role="group" aria-label="Filter by status">
    <button type="button" class="filter-chip is-active" data-filter="all">All stages</button>
    <button type="button" class="filter-chip" data-filter="todo">Todo</button>
    <button type="button" class="filter-chip" data-filter="in-progress">In progress</button>
    <button type="button" class="filter-chip" data-filter="published">Published</button>
  </div>
</div>

<div class="kanban-board" data-archive-list aria-label="Read-only writing roadmap">
  {% assign roadmap_statuses = 'todo,in-progress,published' | split: ',' %}
  {% for stage in roadmap_statuses %}
    {% assign stage_posts = site.posts | where: 'status', stage %}
    <section class="kanban-column kanban-{{ stage }}" data-status-column="{{ stage }}">
      <header class="kanban-column-header">
        <div>
          {% case stage %}{% when 'todo' %}<span>01</span><h2>Todo</h2>{% when 'in-progress' %}<span>02</span><h2>In progress</h2>{% when 'published' %}<span>03</span><h2>Published</h2>{% endcase %}
        </div>
        <strong data-column-count>{{ stage_posts.size }}</strong>
      </header>
      <div class="kanban-stack">
        {% for post in stage_posts %}
          <article class="kanban-card" data-roadmap-card data-status="{{ post.status }}" data-search="{{ post.title | downcase }} {{ post.description | downcase }} {{ post.tags | join: ' ' | downcase }} {{ post.people | join: ' ' | downcase }}">
            <div class="writing-meta"><span>{{ post.content_type | default: 'essay' }}</span><span>{{ post.status | replace: '-', ' ' }}</span></div>
            <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
            <p>{{ post.description }}</p>
            {% if post.next_step %}<p class="kanban-next"><strong>Next:</strong> {{ post.next_step }}</p>{% endif %}
            <div class="writing-tags">{% for tag in post.tags limit: 3 %}<span>{{ tag | replace: '-', ' ' }}</span>{% endfor %}</div>
          </article>
        {% endfor %}
        <p class="kanban-empty"{% if stage_posts.size > 0 %} hidden{% endif %}>{% if stage == 'published' %}No finished essays yet. The first one will appear here only after it meets the publication bar.{% else %}No notes at this stage.{% endif %}</p>
      </div>
    </section>
  {% endfor %}
</div>
<p class="empty-state" data-archive-empty hidden>No roadmap item matches that combination.</p>

{% include suggestion-cta.html %}

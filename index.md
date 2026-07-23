---
layout: default
title: "Computation, emergence, and the architectures of life"
description: "A connected research notebook by Srinivas Venkatanarayanan, Research Engineer at NVIDIA."
permalink: /
---
<section class="hero">
  <div class="site-shell hero-grid">
    <div class="hero-copy">
      <p class="eyebrow">A connected research notebook</p>
      <h1>How do simple rules become <em>living worlds?</em></h1>
      <p class="hero-deck">I study the recurring architectures behind computation, evolution, morphogenesis, intelligence, and collective behavior, then turn the connections into essays, simulations, and research.</p>
      <div class="hero-actions">
        <a class="button button-primary" href="{{ '/writing/' | relative_url }}">Read the writing</a>
        <a class="button button-secondary" href="{{ '/explore/' | relative_url }}">Explore the concept graph</a>
      </div>
      <p class="hero-byline"><strong>Srinivas Venkatanarayanan</strong> · Research Engineer at NVIDIA · Writing independently</p>
    </div>
    <div class="constellation" aria-label="A conceptual path from rules through form, adaptation, mind, and society">
      <span class="orbit orbit-one"></span>
      <span class="orbit orbit-two"></span>
      <div class="concept-node node-rules">rules</div>
      <div class="concept-node node-form">form</div>
      <div class="concept-node node-adaptation">adaptation</div>
      <div class="concept-node node-mind">mind</div>
      <div class="concept-node node-society">society</div>
      <p>one question,<br>many scales</p>
    </div>
  </div>
</section>

<section class="home-section site-shell">
  <div class="section-heading">
    <div>
      <p class="eyebrow">Research program</p>
      <h2>Four paths grounded in current work</h2>
    </div>
    <p>Each path links directly to notes already in the notebook. New paths appear only when there is real writing behind them.</p>
  </div>
  <div class="topic-grid">
    {% for topic in site.data.topics %}
      <a class="topic-card" href="{{ '/explore/' | relative_url }}#{{ topic.slug }}">
        <span class="topic-number">0{{ forloop.index }}</span>
        <h3>{{ topic.name }}</h3>
        <p>{{ topic.question }}</p>
        <small>{{ topic.bridge }}</small>
      </a>
    {% endfor %}
  </div>
</section>

<section class="home-section home-section-dark">
  <div class="site-shell">
    <div class="section-heading">
      <div>
        <p class="eyebrow">Open notebook</p>
        <h2>Work currently moving</h2>
      </div>
      <a class="text-link" href="{{ '/writing/' | relative_url }}">Browse all writing →</a>
    </div>
    <div class="writing-grid">
      {% assign active_posts = site.posts | where: 'status', 'in-progress' %}
      {% for post in active_posts limit: 3 %}
        <article class="writing-card">
          <div class="writing-meta">
            <span>{{ post.content_type | default: 'essay' }}</span>
            <span>{{ post.status | default: 'published' }}</span>
          </div>
          <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
          <p>{{ post.description }}</p>
          <div class="writing-tags">
            {% for tag in post.tags limit: 3 %}<span>{{ tag | replace: '-', ' ' }}</span>{% endfor %}
          </div>
        </article>
      {% endfor %}
    </div>
  </div>
</section>

<section class="home-section site-shell inquiry-section">
  <div>
    <p class="eyebrow">The working method</p>
    <h2>Observe → formalize → simulate → connect.</h2>
  </div>
  <div class="inquiry-steps">
    <p><span>01</span><strong>Begin with an anomaly.</strong> A pinecone, a regenerating organism, a cellular automaton, or a strange social equilibrium.</p>
    <p><span>02</span><strong>Find the transferable mechanism.</strong> Identify constraints, information flows, selection pressures, and state transitions.</p>
    <p><span>03</span><strong>Build something falsifiable.</strong> A model, simulation, visual argument, or set of competing predictions.</p>
    <p><span>04</span><strong>Publish the trail.</strong> Notes become essays; essays become reproducible experiments; the strongest experiments become papers.</p>
  </div>
</section>

<section class="newsletter-band">
  <div class="site-shell newsletter-inner">
    <div>
      <p class="eyebrow">A signal, not a feed</p>
      <h2>One substantial dispatch every two weeks.</h2>
      <p>Until the newsletter launches, follow via RSS or GitHub.</p>
    </div>
    <div class="hero-actions">
      <a class="button button-primary" href="{{ '/feed.xml' | relative_url }}">Subscribe by RSS</a>
      <a class="button button-secondary" href="https://github.com/Vi-Sri/vi-sri.github.io">Watch on GitHub</a>
    </div>
  </div>
</section>

---
---
(function () {
  "use strict";

  const SEARCH_INDEX = [
    {% for post in site.posts %}{
      title: {{ post.title | jsonify }},
      description: {{ post.description | jsonify }},
      url: {{ post.url | relative_url | jsonify }},
      type: {{ post.content_type | default: "writing" | jsonify }},
      terms: {{ post.tags | concat: post.people | join: " " | jsonify }}
    },{% endfor %}
    { title: "Research", description: "Active directions, evidence ladder, and research integrity.", url: "{{ '/research/' | relative_url }}", type: "page", terms: "preprints papers experiments collaboration" },
    { title: "About Srinivas", description: "Research Engineer at NVIDIA working across computation, evolution, and intelligence.", url: "{{ '/about/' | relative_url }}", type: "page", terms: "NVIDIA experience biography computer vision machine learning" },
    { title: "Explore the concept graph", description: "Search ideas and follow connections across the notebook.", url: "{{ '/explore/' | relative_url }}", type: "page", terms: "graph tags concepts people connected notes" }
  ];

  const normalize = (value) => (value || "").toLowerCase().replace(/[-_]/g, " ");
  const matches = (item, query) => normalize([item.title, item.description, item.terms].join(" ")).includes(normalize(query));

  function setupNavigation() {
    const toggle = document.querySelector(".nav-toggle");
    const nav = document.querySelector(".site-nav");
    if (!toggle || !nav) return;
    toggle.addEventListener("click", () => {
      const open = nav.classList.toggle("is-open");
      toggle.setAttribute("aria-expanded", String(open));
    });
  }

  function setupSearch() {
    const dialog = document.querySelector("[data-search-dialog]");
    if (!dialog) return;
    const input = dialog.querySelector("[data-global-search]");
    const results = dialog.querySelector("[data-global-results]");

    const open = () => {
      dialog.showModal();
      window.setTimeout(() => input.focus(), 20);
    };
    const close = () => dialog.close();

    document.querySelectorAll("[data-search-open]").forEach((button) => button.addEventListener("click", open));
    dialog.querySelector("[data-search-close]").addEventListener("click", close);
    dialog.addEventListener("click", (event) => {
      if (event.target === dialog) close();
    });
    document.addEventListener("keydown", (event) => {
      if (event.key === "/" && !/input|textarea/i.test(document.activeElement.tagName)) {
        event.preventDefault();
        open();
      }
    });

    input.addEventListener("input", () => {
      const query = input.value.trim();
      results.replaceChildren();
      if (!query) {
        const hint = document.createElement("p");
        hint.className = "search-hint";
        hint.textContent = "Start typing to search titles, summaries, tags, people, and concepts.";
        results.append(hint);
        return;
      }
      const found = SEARCH_INDEX.filter((item) => matches(item, query)).slice(0, 8);
      if (!found.length) {
        const empty = document.createElement("p");
        empty.className = "search-hint";
        empty.textContent = "No direct match yet. Try a broader concept.";
        results.append(empty);
        return;
      }
      found.forEach((item) => {
        const link = document.createElement("a");
        link.className = "search-result";
        link.href = item.url;
        const title = document.createElement("strong");
        title.textContent = item.title;
        const meta = document.createElement("small");
        meta.textContent = `${item.type} — ${item.description}`;
        link.append(title, meta);
        link.addEventListener("click", () => {
          if (window.trackSiteEvent) window.trackSiteEvent("search_result_selected", { search_term: query, content_type: item.type, item_name: item.title });
        });
        results.append(link);
      });
    });
  }

  function setupArchive() {
    const input = document.querySelector("[data-archive-search]");
    const list = document.querySelector("[data-archive-list]");
    if (!input || !list) return;
    const items = Array.from(list.querySelectorAll(".archive-item"));
    const empty = document.querySelector("[data-archive-empty]");
    let status = "all";

    const apply = () => {
      const query = normalize(input.value.trim());
      let visible = 0;
      items.forEach((item) => {
        const statusMatch = status === "all" || item.dataset.status === status;
        const queryMatch = !query || normalize(item.dataset.search).includes(query);
        item.hidden = !(statusMatch && queryMatch);
        if (!item.hidden) visible += 1;
      });
      if (empty) empty.hidden = visible !== 0;
    };

    input.addEventListener("input", apply);
    input.addEventListener("change", () => {
      if (input.value.trim() && window.trackSiteEvent) window.trackSiteEvent("search", { search_term: input.value.trim(), search_surface: "writing_archive" });
    });
    document.querySelectorAll("[data-filter]").forEach((button) => {
      button.addEventListener("click", () => {
        status = button.dataset.filter;
        document.querySelectorAll("[data-filter]").forEach((chip) => chip.classList.toggle("is-active", chip === button));
        apply();
      });
    });
  }

  function setupExploreFilter() {
    const input = document.querySelector("[data-explore-search]");
    if (!input) return;
    const items = Array.from(document.querySelectorAll("[data-explore-item]"));
    const apply = () => {
      const query = normalize(input.value.trim());
      items.forEach((item) => { item.hidden = Boolean(query) && !normalize(item.dataset.search).includes(query); });
    };
    const initial = new URLSearchParams(window.location.search).get("q");
    if (initial) input.value = initial.replace(/-/g, " ");
    input.addEventListener("input", apply);
    input.addEventListener("change", () => {
      if (input.value.trim() && window.trackSiteEvent) window.trackSiteEvent("search", { search_term: input.value.trim(), search_surface: "concept_graph" });
    });
    apply();
  }

  function setupGraph() {
    const canvas = document.querySelector("[data-concept-graph]");
    const source = document.getElementById("graph-data");
    if (!canvas || !source) return;

    let data;
    try { data = JSON.parse(source.textContent); } catch (_) { return; }

    const context = canvas.getContext("2d");
    const countLabel = document.querySelector("[data-graph-count]");
    const reset = document.querySelector("[data-graph-reset]");
    const palette = { background: "#122c23", line: "rgba(233,225,209,.18)", concept: "#d47a59", post: "#dfe7e1", label: "#f5f0e5", muted: "#93a99a" };
    const nodeMap = new Map();
    const links = [];
    let selected = null;
    let hovered = null;
    let width = 0;
    let height = 0;

    const hash = (text) => Array.from(text).reduce((value, character) => ((value << 5) - value + character.charCodeAt(0)) | 0, 0);
    const ensureNode = (id, label, type, url) => {
      if (!nodeMap.has(id)) {
        const angle = Math.abs(hash(id)) % 628 / 100;
        const radial = type === "concept" ? 0.28 : 0.42;
        nodeMap.set(id, { id, label, type, url, angle, radial, x: 0, y: 0, radius: type === "concept" ? 8 : 4 });
      }
      return nodeMap.get(id);
    };

    data.posts.forEach((post) => {
      const postNode = ensureNode(`post:${post.id}`, post.title, "post", post.url);
      [...(post.tags || []), ...(post.people || [])].forEach((term) => {
        const id = `concept:${normalize(term).replace(/\s+/g, "-")}`;
        const conceptNode = ensureNode(id, term, "concept", null);
        links.push({ source: conceptNode, target: postNode });
      });
    });
    const nodes = Array.from(nodeMap.values());

    const positionNodes = () => {
      const centerX = width / 2;
      const centerY = height / 2;
      const scale = Math.min(width, height);
      nodes.forEach((node) => {
        node.x = centerX + Math.cos(node.angle) * scale * node.radial;
        node.y = centerY + Math.sin(node.angle) * scale * node.radial;
      });
      for (let iteration = 0; iteration < 90; iteration += 1) {
        links.forEach((link) => {
          const dx = link.target.x - link.source.x;
          const dy = link.target.y - link.source.y;
          link.source.x += dx * 0.014;
          link.source.y += dy * 0.014;
          link.target.x -= dx * 0.014;
          link.target.y -= dy * 0.014;
        });
        for (let index = 0; index < nodes.length; index += 1) {
          for (let next = index + 1; next < nodes.length; next += 1) {
            const first = nodes[index];
            const second = nodes[next];
            const dx = second.x - first.x;
            const dy = second.y - first.y;
            const distanceSquared = Math.max(dx * dx + dy * dy, 70);
            const force = 14 / distanceSquared;
            first.x -= dx * force;
            first.y -= dy * force;
            second.x += dx * force;
            second.y += dy * force;
          }
        }
        nodes.forEach((node) => {
          node.x += (centerX - node.x) * 0.002;
          node.y += (centerY - node.y) * 0.002;
          node.x = Math.max(28, Math.min(width - 28, node.x));
          node.y = Math.max(28, Math.min(height - 28, node.y));
        });
      }
    };

    const isNeighbor = (node) => !selected || node === selected || links.some((link) => (link.source === selected && link.target === node) || (link.target === selected && link.source === node));
    const draw = () => {
      context.clearRect(0, 0, width, height);
      context.fillStyle = palette.background;
      context.fillRect(0, 0, width, height);
      links.forEach((link) => {
        const active = !selected || link.source === selected || link.target === selected;
        context.strokeStyle = active ? palette.line : "rgba(233,225,209,.04)";
        context.lineWidth = active && selected ? 1.4 : 0.7;
        context.beginPath();
        context.moveTo(link.source.x, link.source.y);
        context.lineTo(link.target.x, link.target.y);
        context.stroke();
      });
      nodes.forEach((node) => {
        const active = isNeighbor(node);
        context.globalAlpha = active ? 1 : 0.18;
        context.fillStyle = node.type === "concept" ? palette.concept : palette.post;
        context.beginPath();
        context.arc(node.x, node.y, node === selected || node === hovered ? node.radius + 3 : node.radius, 0, Math.PI * 2);
        context.fill();
        if (node.type === "concept" || node === selected || node === hovered) {
          context.fillStyle = active ? palette.label : palette.muted;
          context.font = `${node.type === "concept" ? 11 : 10}px ui-monospace, monospace`;
          context.textAlign = "center";
          context.fillText(node.label.length > 34 ? `${node.label.slice(0, 32)}…` : node.label, node.x, node.y - node.radius - 7);
        }
      });
      context.globalAlpha = 1;
      if (countLabel) countLabel.textContent = selected ? `Neighborhood of ${selected.label}` : `${nodes.length} nodes · ${links.length} conceptual links`;
    };

    const resize = () => {
      const ratio = window.devicePixelRatio || 1;
      const rect = canvas.getBoundingClientRect();
      width = rect.width;
      height = rect.height;
      canvas.width = Math.round(width * ratio);
      canvas.height = Math.round(height * ratio);
      context.setTransform(ratio, 0, 0, ratio, 0, 0);
      positionNodes();
      draw();
    };

    const nodeAt = (event) => {
      const rect = canvas.getBoundingClientRect();
      const x = event.clientX - rect.left;
      const y = event.clientY - rect.top;
      return nodes.find((node) => Math.hypot(node.x - x, node.y - y) < node.radius + 8) || null;
    };

    canvas.addEventListener("pointermove", (event) => {
      hovered = nodeAt(event);
      canvas.style.cursor = hovered ? "pointer" : "crosshair";
      draw();
    });
    canvas.addEventListener("pointerleave", () => { hovered = null; draw(); });
    canvas.addEventListener("click", (event) => {
      const node = nodeAt(event);
      if (!node) { selected = null; draw(); return; }
      if (node.type === "post" && selected === node && node.url) {
        if (window.trackSiteEvent) window.trackSiteEvent("select_content", { content_type: "graph_post", item_id: node.id, item_name: node.label });
        window.location.href = node.url;
        return;
      }
      selected = selected === node ? null : node;
      if (selected && window.trackSiteEvent) window.trackSiteEvent("graph_node_selected", { node_type: node.type, item_id: node.id, item_name: node.label });
      draw();
    });
    if (reset) reset.addEventListener("click", () => { selected = null; hovered = null; draw(); });
    window.addEventListener("resize", resize, { passive: true });
    resize();
  }

  setupNavigation();
  setupSearch();
  setupArchive();
  setupExploreFilter();
  setupGraph();
})();

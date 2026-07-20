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
    const items = Array.from(list.querySelectorAll("[data-roadmap-card], .archive-item"));
    const columns = Array.from(list.querySelectorAll("[data-status-column]"));
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
      columns.forEach((column) => {
        const cards = Array.from(column.querySelectorAll("[data-roadmap-card]"));
        const visibleCards = cards.filter((card) => !card.hidden).length;
        const count = column.querySelector("[data-column-count]");
        const columnEmpty = column.querySelector(".kanban-empty");
        column.hidden = status !== "all" && column.dataset.statusColumn !== status;
        if (count) count.textContent = String(visibleCards);
        if (columnEmpty) columnEmpty.hidden = visibleCards !== 0;
      });
      if (empty) empty.hidden = visible !== 0 || !query;
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
    const detail = document.querySelector("[data-graph-detail]");
    const search = document.querySelector("[data-explore-search]");
    const palette = {
      background: "#122c23",
      line: "rgba(233,225,209,.28)",
      active: "#d47a59",
      todo: "#91a69a",
      published: "#f1d59b",
      reference: "#f1d59b",
      label: "#f5f0e5",
      muted: "#7e9388"
    };
    let selected = null;
    let hovered = null;
    let searchMatches = new Set();
    let searchQueryActive = false;
    let width = 0;
    let height = 0;

    const nodes = data.posts.map((post, index) => ({ ...post, index, x: 0, y: 0, radius: 9 }));
    const nodeById = new Map(nodes.map((node) => [node.id, node]));
    const linkMap = new Map();
    const linkKey = (first, second) => [first.id, second.id].sort().join("::");
    const ensureLink = (source, target) => {
      const key = linkKey(source, target);
      if (!linkMap.has(key)) linkMap.set(key, { source, target, shared: [], references: [] });
      return linkMap.get(key);
    };
    const normalizedTerms = (node) => (node.tags || []).map((term) => normalize(term));
    nodes.forEach((sourceNode, index) => {
      nodes.slice(index + 1).forEach((targetNode) => {
        const targetTerms = new Set(normalizedTerms(targetNode));
        const shared = (sourceNode.tags || []).filter((term) => targetTerms.has(normalize(term)));
        if (shared.length) ensureLink(sourceNode, targetNode).shared.push(...shared);
      });
      (sourceNode.wikilinks || []).forEach((reference) => {
        const targetNode = nodeById.get(reference.target_id);
        if (!targetNode || targetNode === sourceNode) return;
        ensureLink(sourceNode, targetNode).references.push({ ...reference, source_id: sourceNode.id });
      });
    });
    const links = Array.from(linkMap.values());

    const positionNodes = () => {
      const centerX = width / 2;
      const centerY = height / 2;
      const radiusX = Math.max(95, width * 0.34);
      const radiusY = Math.max(100, height * 0.34);
      nodes.forEach((node, index) => {
        const angle = -Math.PI / 2 + (Math.PI * 2 * index) / Math.max(nodes.length, 1);
        node.x = centerX + Math.cos(angle) * radiusX;
        node.y = centerY + Math.sin(angle) * radiusY;
      });
    };

    const directLinks = (node) => links.filter((link) => link.source === node || link.target === node);
    const isNeighbor = (node) => !selected || node === selected || directLinks(selected).some((link) => link.source === node || link.target === node);
    const nodeColor = (node) => node.status === "published" ? palette.published : node.status === "in-progress" ? palette.active : palette.todo;

    const updateDetail = () => {
      if (!detail) return;
      detail.replaceChildren();
      const eyebrow = document.createElement("p");
      eyebrow.className = "eyebrow";
      if (!selected) {
        eyebrow.textContent = "How to read this";
        const title = document.createElement("h2");
        title.textContent = "Select a note";
        const copy = document.createElement("p");
        copy.textContent = "The selected note becomes the visual focus. Gold lines are deliberate wikilinks; thin lines are shared tags. The references and their sections appear here.";
        detail.append(eyebrow, title, copy);
        return;
      }

      eyebrow.textContent = `${selected.contentType} · ${selected.status.replace(/-/g, " ")}`;
      const title = document.createElement("h2");
      title.textContent = selected.title;
      const description = document.createElement("p");
      description.textContent = selected.description;
      const concepts = document.createElement("div");
      concepts.className = "graph-concepts";
      (selected.tags || []).forEach((term) => {
        const tag = document.createElement("span");
        tag.textContent = term.replace(/-/g, " ");
        concepts.append(tag);
      });
      const connections = directLinks(selected);
      const connectionTitle = document.createElement("h3");
      connectionTitle.textContent = "Connections and references";
      const connectionList = document.createElement("ul");
      connectionList.className = "graph-connections";
      if (!connections.length) {
        const item = document.createElement("li");
        item.textContent = "No shared concepts with another note yet.";
        connectionList.append(item);
      } else {
        connections.forEach((connection) => {
          const other = connection.source === selected ? connection.target : connection.source;
          const item = document.createElement("li");
          const link = document.createElement("a");
          link.href = other.url;
          link.textContent = other.title;
          item.append(link);
          if (connection.shared.length) {
            const via = document.createElement("small");
            via.className = "graph-shared-reference";
            via.textContent = `Shared tags: ${connection.shared.map((term) => term.replace(/-/g, " ")).join(", ")}`;
            item.append(via);
          }
          connection.references.forEach((reference) => {
            const citation = document.createElement("small");
            citation.className = "graph-wiki-reference";
            const outgoing = reference.source_id === selected.id;
            const direction = outgoing ? "This note references the connected note" : "The connected note references this one";
            const sourceSection = reference.source_section ? ` from § “${reference.source_section}”` : "";
            const targetSection = reference.target_section ? ` to § “${reference.target_section}”` : "";
            citation.textContent = `${direction}${sourceSection}${targetSection}.`;
            item.append(citation);
          });
          connectionList.append(item);
        });
      }
      const open = document.createElement("a");
      open.className = "button button-primary graph-open-note";
      open.href = selected.url;
      open.textContent = "Open this working note";
      open.addEventListener("click", () => {
        if (window.trackSiteEvent) window.trackSiteEvent("select_content", { content_type: "graph_post", item_id: selected.id, item_name: selected.title });
      });
      detail.append(eyebrow, title, description, concepts, connectionTitle, connectionList, open);
    };

    const drawLabel = (node, active) => {
      const words = node.title.split(/\s+/);
      const lines = [];
      let line = "";
      words.forEach((word) => {
        const candidate = line ? `${line} ${word}` : word;
        if (candidate.length > 25 && line && lines.length < 2) {
          lines.push(line);
          line = word;
        } else {
          line = candidate;
        }
      });
      if (line && lines.length < 2) lines.push(line);
      if (lines.length === 2 && words.join(" ").length > lines.join(" ").length) lines[1] = `${lines[1].slice(0, 22)}…`;
      context.fillStyle = active ? palette.label : palette.muted;
      context.font = `${node === selected ? "600 " : ""}11px ui-sans-serif, system-ui, sans-serif`;
      context.textAlign = "center";
      lines.forEach((text, index) => context.fillText(text, node.x, node.y + 28 + index * 14));
    };

    const draw = () => {
      context.clearRect(0, 0, width, height);
      context.fillStyle = palette.background;
      context.fillRect(0, 0, width, height);
      links.forEach((link) => {
        const active = !selected || link.source === selected || link.target === selected;
        const searchActive = !searchQueryActive || searchMatches.has(link.source.id) || searchMatches.has(link.target.id);
        const explicit = link.references.length > 0;
        context.globalAlpha = active && searchActive ? 1 : 0.12;
        context.strokeStyle = explicit ? palette.reference : active && selected ? palette.active : palette.line;
        context.lineWidth = explicit ? (active && selected ? 3 : 2) : active && selected ? 2 : 1;
        context.setLineDash(explicit ? [8, 4] : []);
        context.beginPath();
        context.moveTo(link.source.x, link.source.y);
        context.lineTo(link.target.x, link.target.y);
        context.stroke();
        context.setLineDash([]);
        if (selected && active) {
          const labels = [];
          if (explicit) labels.push(`${link.references.length} wiki reference${link.references.length === 1 ? "" : "s"}`);
          if (link.shared.length) labels.push(link.shared.map((term) => term.replace(/-/g, " ")).join(" · "));
          const label = labels.join(" + ");
          const x = (link.source.x + link.target.x) / 2;
          const y = (link.source.y + link.target.y) / 2;
          context.font = "10px ui-monospace, monospace";
          const labelWidth = context.measureText(label).width + 12;
          context.fillStyle = palette.background;
          context.fillRect(x - labelWidth / 2, y - 10, labelWidth, 18);
          context.fillStyle = palette.label;
          context.textAlign = "center";
          context.fillText(label, x, y + 3);
        }
      });
      nodes.forEach((node) => {
        const active = isNeighbor(node) && (!searchQueryActive || searchMatches.has(node.id));
        context.globalAlpha = active ? 1 : 0.18;
        context.fillStyle = nodeColor(node);
        const radius = node === selected ? 15 : node === hovered || (selected && isNeighbor(node)) ? 11 : node.radius;
        context.beginPath();
        context.arc(node.x, node.y, radius, 0, Math.PI * 2);
        context.fill();
        if (node === selected) {
          context.strokeStyle = palette.label;
          context.lineWidth = 2;
          context.beginPath();
          context.arc(node.x, node.y, 21, 0, Math.PI * 2);
          context.stroke();
        }
        drawLabel(node, active);
      });
      context.globalAlpha = 1;
      if (countLabel) {
        if (selected) {
          const selectedLinks = directLinks(selected);
          const referenceCount = selectedLinks.reduce((total, link) => total + link.references.length, 0);
          countLabel.textContent = `${selected.title} · ${selectedLinks.length} connection${selectedLinks.length === 1 ? "" : "s"} · ${referenceCount} wiki reference${referenceCount === 1 ? "" : "s"}`;
        }
        else if (searchQueryActive) countLabel.textContent = searchMatches.size ? `${searchMatches.size} matching note${searchMatches.size === 1 ? "" : "s"}` : "No notes match this search";
        else {
          const referenceCount = links.reduce((total, link) => total + link.references.length, 0);
          countLabel.textContent = `${nodes.length} actual notes · ${links.length} connections · ${referenceCount} wiki references`;
        }
      }
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
      return nodes.find((node) => Math.hypot(node.x - x, node.y - y) < 24) || null;
    };

    canvas.addEventListener("pointermove", (event) => {
      hovered = nodeAt(event);
      canvas.style.cursor = hovered ? "pointer" : "default";
      draw();
    });
    canvas.addEventListener("pointerleave", () => { hovered = null; draw(); });
    canvas.addEventListener("click", (event) => {
      const node = nodeAt(event);
      if (!node) { selected = null; updateDetail(); draw(); return; }
      selected = selected === node ? null : node;
      if (selected && window.trackSiteEvent) window.trackSiteEvent("graph_node_selected", { node_type: "post", item_id: node.id, item_name: node.title });
      updateDetail();
      draw();
    });
    if (search) {
      const applyGraphSearch = () => {
        const query = normalize(search.value.trim());
        searchQueryActive = Boolean(query);
        searchMatches = new Set(query ? nodes.filter((node) => normalize([node.title, node.description, ...(node.tags || []), ...(node.people || []), ...(node.wikilinks || []).flatMap((reference) => [reference.target_title, reference.target_section, reference.source_section])].join(" ")).includes(query)).map((node) => node.id) : []);
        selected = searchMatches.size === 1 ? nodes.find((node) => searchMatches.has(node.id)) : null;
        updateDetail();
        draw();
      };
      search.addEventListener("input", applyGraphSearch);
      applyGraphSearch();
    }
    if (reset) reset.addEventListener("click", () => {
      selected = null;
      hovered = null;
      searchMatches = new Set();
      searchQueryActive = false;
      if (search) search.value = "";
      document.querySelectorAll("[data-explore-item]").forEach((item) => { item.hidden = false; });
      updateDetail();
      draw();
    });
    window.addEventListener("resize", resize, { passive: true });
    resize();
  }

  function setupTrackedLinks() {
    document.querySelectorAll('[data-track="suggestion"]').forEach((link) => {
      link.addEventListener("click", () => {
        if (window.trackSiteEvent) window.trackSiteEvent("generate_lead", { lead_source: link.dataset.suggestionChannel || "unknown", content_type: "topic_suggestion" });
      });
    });
  }

  setupNavigation();
  setupSearch();
  setupArchive();
  setupExploreFilter();
  setupGraph();
  setupTrackedLinks();
})();

# frozen_string_literal: true

require "cgi"

module ConnectedNotebook
  WIKILINK_PATTERN = /(?<!\\)\[\[([^\[\]\n]+)\]\]/.freeze
  FENCE_PATTERN = /^\s*(`{3,}|~{3,})/.freeze
  HEADING_PATTERN = /^\s{0,3}([#]{1,6})\s+(.+?)\s*#*\s*$/.freeze

  class WikiLinksGenerator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      @site = site
      @documents = collect_documents(site)
      @lookup = build_lookup(@documents)
      @heading_index = @documents.to_h { |document| [document, headings_for(document.content)] }
      @errors = []
      @documents.each do |document|
        document.data["wikilink_id"] = document_id(document)
        document.data["wikilinks"] = []
        document.data["backlinks"] = []
      end
      @documents.each { |document| process_document(document) }
      if strict? && @errors.any?
        raise Jekyll::Errors::FatalException, "Wikilink validation failed:\n- #{@errors.join("\n- ")}"
      end
    end

    private

    def collect_documents(site)
      collection_documents = site.collections.values.flat_map(&:docs)
      (collection_documents + site.pages).uniq.select do |document|
        document.respond_to?(:content) && document.content.is_a?(String)
      end
    end

    def build_lookup(documents)
      lookup = {}
      documents.each do |document|
        keys_for(document).each do |key|
          normalized_keys(key).each do |normalized|
            next if normalized.empty?

            if lookup.key?(normalized) && lookup[normalized] != document
              Jekyll.logger.warn "Wikilinks:", "duplicate target '#{key}'"
            else
              lookup[normalized] = document
            end
          end
        end
      end
      lookup
    end

    def keys_for(document)
      return [] if document.data["layout"] == "redirect"

      keys = [document.data["title"], document_id(document)]
      keys.concat(Array(document.data["aliases"]))
      keys.compact
    end

    def normalized_keys(value)
      text = value.to_s.strip.downcase
      [text, Jekyll::Utils.slugify(text)].uniq
    end

    def document_id(document)
      return document.data["wikilink_id"] if document.data["wikilink_id"]

      url_parts = document.url.to_s.split("/").reject(&:empty?)
      url_parts.last || document.data["slug"] || document.data["title"].to_s
    end

    def process_document(document)
      in_fence = false
      fence_character = nil
      current_heading = nil

      rendered_content = document.content.lines.map do |line|
        if (fence = line.match(FENCE_PATTERN))
          marker = fence[1][0]
          if !in_fence
            in_fence = true
            fence_character = marker
          elsif fence_character == marker
            in_fence = false
            fence_character = nil
          end
          next line
        end

        unless in_fence
          if (heading = line.match(HEADING_PATTERN))
            heading_text = clean_heading(heading[2])
            current_heading = {
              "title" => heading_text,
              "anchor" => Jekyll::Utils.slugify(heading_text)
            }
          end
          line = rewrite_outside_inline_code(line, document, current_heading)
        end
        line
      end.join
      document.data["_wikilink_rendered_content"] = rendered_content
    end

    def headings_for(content)
      headings = []
      in_fence = false
      fence_character = nil
      content.lines.each do |line|
        if (fence = line.match(FENCE_PATTERN))
          marker = fence[1][0]
          if !in_fence
            in_fence = true
            fence_character = marker
          elsif fence_character == marker
            in_fence = false
            fence_character = nil
          end
          next
        end
        next if in_fence

        heading = line.match(HEADING_PATTERN)
        headings << Jekyll::Utils.slugify(clean_heading(heading[2])) if heading
      end
      headings
    end

    def rewrite_outside_inline_code(line, document, current_heading)
      line.split(/(`+[^`]*`+)/).map.with_index do |segment, index|
        index.odd? ? segment : rewrite_segment(segment, document, current_heading)
      end.join
    end

    def rewrite_segment(segment, document, current_heading)
      segment.gsub(WIKILINK_PATTERN) do
        raw_reference = Regexp.last_match(1).strip
        render_reference(raw_reference, document, current_heading)
      end.gsub("\\[[", "[[")
    end

    def render_reference(raw_reference, source, source_heading)
      destination, custom_label = raw_reference.split("|", 2).map { |part| part&.strip }
      target_name, target_section = destination.split("#", 2).map { |part| part&.strip }
      target = target_name.to_s.empty? ? source : resolve(target_name)

      unless target
        problem = "unresolved '#{raw_reference}' in #{source.relative_path}"
        @errors << problem
        Jekyll.logger.warn "Wikilinks:", problem
        return %(<span class="wikilink-unresolved" title="Unresolved note">#{CGI.escapeHTML(custom_label || raw_reference)}</span>)
      end

      target_anchor = target_section.to_s.empty? ? nil : Jekyll::Utils.slugify(target_section)
      if target_anchor && !@heading_index.fetch(target, []).include?(target_anchor)
        problem = "missing section '#{target_section}' on '#{target.data["title"]}' (linked from #{source.relative_path})"
        @errors << problem
        Jekyll.logger.warn "Wikilinks:", problem
      end
      label = custom_label.to_s.empty? ? destination : custom_label
      href = site_url(target.url, target_anchor)
      target_id = document_id(target)
      source_id = document_id(source)
      reference = {
        "target_id" => target_id,
        "target_title" => target.data["title"],
        "target_url" => target.url,
        "target_section" => target_section,
        "target_anchor" => target_anchor,
        "source_section" => source_heading && source_heading["title"],
        "source_anchor" => source_heading && source_heading["anchor"],
        "label" => label
      }
      source.data["wikilinks"] << reference

      unless source == target
        target.data["backlinks"] << {
          "source_id" => source_id,
          "source_title" => source.data["title"],
          "source_url" => source.url,
          "source_section" => source_heading && source_heading["title"],
          "source_anchor" => source_heading && source_heading["anchor"],
          "target_section" => target_section,
          "label" => label
        }
      end

      %(<a class="wikilink" href="#{CGI.escapeHTML(href)}" data-wikilink-target="#{CGI.escapeHTML(target_id)}">#{CGI.escapeHTML(label)}</a>)
    end

    def resolve(name)
      normalized_keys(name).each do |key|
        return @lookup[key] if @lookup.key?(key)
      end
      nil
    end

    def site_url(url, anchor)
      baseurl = @site.config["baseurl"].to_s.sub(%r{/$}, "")
      result = "#{baseurl}#{url}"
      anchor ? "#{result}##{anchor}" : result
    end

    def clean_heading(value)
      value.to_s
           .gsub(/\[([^\]]+)\]\([^\)]+\)/, '\\1')
           .gsub(/[*_`]/, "")
           .strip
    end

    def strict?
      @site.config.fetch("wikilinks", {}).fetch("strict", false)
    end
  end

  Jekyll::Hooks.register :documents, :pre_render do |document, _payload|
    rendered_content = document.data.delete("_wikilink_rendered_content")
    document.content = rendered_content if rendered_content
  end

  Jekyll::Hooks.register :pages, :pre_render do |page, _payload|
    rendered_content = page.data.delete("_wikilink_rendered_content")
    page.content = rendered_content if rendered_content
  end
end

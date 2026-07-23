#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "digest"
require "fileutils"
require "json"
require "pathname"
require "yaml"

class ObsidianBlog
  Note = Struct.new(:path, :relative_path, :data, :body, keyword_init: true)

  ALLOWED_STATUSES = %w[todo in-progress published].freeze
  REQUIRED_PROPERTIES = %w[title description date status content_type].freeze
  WIKILINK_PATTERN = /(?<!!)(?<!\\)\[\[([^\[\]\n]+)\]\]/.freeze
  EMBED_PATTERN = /!\[\[([^\[\]\n]+)\]\]/.freeze
  FENCE_PATTERN = /^\s*(`{3,}|~{3,})/.freeze
  HEADING_PATTERN = /^\s{0,3}([#]{1,6})\s+(.+?)\s*#*\s*$/.freeze
  IMAGE_EXTENSIONS = %w[.avif .gif .jpeg .jpg .png .svg .webp].freeze
  DOWNLOAD_EXTENSIONS = %w[.csv .json .pdf .txt .zip].freeze
  EM_DASH = "\u2014"

  def initialize(root: Pathname.new(__dir__).join("..").expand_path)
    @root = root
    @config_path = @root.join(".obsidian-blog.yml")
    abort "Missing #{@config_path}. Copy .obsidian-blog.example.yml and set your vault path." unless @config_path.file?

    @config = load_yaml(@config_path)
    @vault = Pathname.new(required_config("vault")).expand_path
    abort "Vault does not exist: #{@vault}" unless @vault.directory?

    @drafts_dir = @config.fetch("drafts_dir", "30 Drafts")
    @templates_dir = @config.fetch("templates_dir", "90 Templates")
    @attachments_dir = @config.fetch("attachments_dir", "Attachments")
    @posts_dir = @root.join(@config.fetch("posts_dir", "_posts"))
    @assets_dir = @root.join(@config.fetch("assets_dir", "assets/notes"))
  end

  def run(arguments)
    command = arguments.shift
    case command
    when "init" then init_vault
    when "import" then import_posts(overwrite: arguments.delete("--overwrite"))
    when "new" then new_draft(arguments.join(" "))
    when "status" then status
    when "normalize-links" then normalize_links
    when "check" then check!
    when "sync" then sync(adopt: arguments.delete("--adopt"))
    when "vault-audit" then vault_audit
    else
      puts <<~HELP
        Usage: bin/blog COMMAND

          init                 Create the vault folders, templates, and dashboard
          import [--overwrite] Import existing Jekyll posts into Obsidian
          new "Title"          Create a private draft and print its Obsidian open command
          status               Show private/exported drafts by editorial stage
          normalize-links      Rewrite alias/title targets to Obsidian-native filename links
          check                Validate public metadata, wikilinks, sections, and embeds
          sync [--adopt]       Compile opted-in drafts and copy referenced attachments
          vault-audit          Ask Obsidian CLI for unresolved links, orphans, and draft count
      HELP
      exit(command ? 1 : 0)
    end
  end

  private

  def init_vault
    directories = [
      "00 Inbox/Web Clips",
      "00 Inbox/References",
      "00 Inbox/AI Intake",
      "10 Sources",
      "20 Concepts",
      @drafts_dir,
      "40 Published",
      @templates_dir,
      @attachments_dir
    ]
    directories.each { |directory| FileUtils.mkdir_p(@vault.join(directory)) }

    write_unless_exists(@vault.join(@templates_dir, "Blog draft.md"), blog_template)
    write_unless_exists(@vault.join(@templates_dir, "Source note.md"), source_template)
    write_unless_exists(@vault.join(@templates_dir, "Reference intake.md"), reference_intake_template)
    write_unless_exists(@vault.join(@templates_dir, "AI intake.md"), ai_intake_template)
    write_unless_exists(@vault.join(@templates_dir, "Concept note.md"), concept_template)
    write_unless_exists(@vault.join("Publishing Board.md"), publishing_board)
    write_unless_exists(@vault.join("VAULT GUIDE.md"), vault_guide)
    configure_obsidian

    puts "Initialized #{@vault}"
    puts "Next: bin/blog import"
  end

  def import_posts(overwrite: false)
    FileUtils.mkdir_p(@vault.join(@drafts_dir))
    imported = 0
    skipped = 0
    Dir[@posts_dir.join("*.md").to_s].sort.each do |source|
      source_path = Pathname.new(source)
      note = parse_note(source_path, source_path.basename.to_s)
      match = source_path.basename(".md").to_s.match(/\A(\d{4}-\d{2}-\d{2})-(.+)\z/)
      next unless match

      date = match[1]
      slug = match[2]
      destination = @vault.join(@drafts_dir, "#{slug}.md")
      if destination.exist? && !overwrite
        skipped += 1
        next
      end

      data = note.data.dup
      data.delete("obsidian_source")
      data.delete("obsidian_sha256")
      data["slug"] ||= slug
      data["date"] ||= date
      data["blog_publish"] = true
      write_note(destination, data, note.body)
      imported += 1
    end
    puts "Imported #{imported} posts into #{@drafts_dir}; skipped #{skipped} existing drafts."
  end

  def new_draft(title)
    abort "Provide a title: bin/blog new \"A precise article title\"" if title.strip.empty?

    slug = slugify(title)
    destination = @vault.join(@drafts_dir, "#{slug}.md")
    abort "Draft already exists: #{destination}" if destination.exist?

    data = {
      "title" => title,
      "slug" => slug,
      "aliases" => [],
      "description" => "",
      "date" => Date.today.iso8601,
      "updated" => Date.today.iso8601,
      "status" => "todo",
      "content_type" => "essay",
      "tags" => [],
      "people" => [],
      "next_step" => "Define the claim, evidence, and first discriminating test.",
      "math" => false,
      "p5" => false,
      "blog_publish" => false
    }
    write_note(destination, data, article_body)
    puts "Created private draft: #{destination}"
    puts %(Open it with: obsidian vault="#{@vault.basename}" open path="#{@drafts_dir}/#{slug}.md")
  end

  def status
    drafts = draft_notes
    puts "Obsidian blog pipeline: #{@vault}"
    ALLOWED_STATUSES.each do |stage|
      notes = drafts.select { |note| note.data["status"].to_s == stage }
      puts "\n#{stage.upcase} (#{notes.size})"
      notes.each do |note|
        visibility = truthy?(note.data["blog_publish"]) ? "exported" : "private"
        puts "  - #{note.data["title"] || note.path.basename(".md")} [#{visibility}]"
      end
    end
  end

  def normalize_links
    all_notes = vault_notes
    lookup, errors = note_lookup(all_notes)
    unless errors.empty?
      warn "Cannot normalize links until note names and aliases are unique:"
      errors.each { |error| warn "  - #{error}" }
      exit 1
    end

    rewrites = []
    draft_notes.each do |note|
      changed_links = 0
      body = transform_outside_code(note.body) do |segment|
        segment.gsub(WIKILINK_PATTERN) do
          raw_reference = Regexp.last_match(1).strip
          destination, display = raw_reference.split("|", 2).map { |part| part&.strip }
          target_name, target_section = destination.split("#", 2).map { |part| part&.strip }
          next Regexp.last_match(0) if target_name.to_s.empty?

          target = resolve_note(lookup, target_name)
          next Regexp.last_match(0) unless target

          canonical_name = target.path.basename(".md").to_s
          next Regexp.last_match(0) if target_name == canonical_name

          canonical_destination = canonical_name.dup
          canonical_destination << "##{target_section}" unless target_section.to_s.empty?
          visible_text = display.to_s.empty? ? destination : display
          changed_links += 1
          "[[#{canonical_destination}|#{visible_text}]]"
        end
      end
      rewrites << [note, body, changed_links] if changed_links.positive?
    end

    rewrites.each { |note, body, _count| write_note(note.path, note.data, body) }
    total = rewrites.sum { |_note, _body, count| count }
    puts "Normalized #{total} links across #{rewrites.size} drafts."
  end

  def check!
    result = validate
    unless result[:errors].empty?
      warn "Obsidian blog validation failed:"
      result[:errors].each { |error| warn "  - #{error}" }
      exit 1
    end

    counts = ALLOWED_STATUSES.to_h { |stage| [stage, result[:exported].count { |note| note.data["status"].to_s == stage }] }
    puts "Validation passed: #{result[:exported].size} exported drafts " \
         "(#{counts["todo"]} todo, #{counts["in-progress"]} in progress, #{counts["published"]} published)."
    puts "Private vault notes remain outside the repository."
    result
  end

  def sync(adopt: false)
    result = check!
    expected_targets = []
    written = 0
    unchanged = 0

    result[:exported].each do |note|
      slug = note_slug(note)
      date = normalized_date(note.data["date"])
      target = @posts_dir.join("#{date}-#{slug}.md")
      expected_targets << target.expand_path.to_s
      if target.exist?
        current = parse_note(target, target.basename.to_s)
        source_matches = current.data["obsidian_source"].to_s == note.relative_path
        abort "Refusing to overwrite unmanaged post #{target}. Run bin/blog sync --adopt once after reviewing the import." unless source_matches || adopt
      end

      body = rewrite_embeds(note, slug, copy: true)
      output_data = export_data(note, slug)
      output = serialize_note(output_data, generated_notice(note) + body)
      if target.exist? && target.read == output
        unchanged += 1
      else
        FileUtils.mkdir_p(target.dirname)
        target.write(output)
        written += 1
      end
    end

    managed_orphans = managed_posts.reject { |path| expected_targets.include?(path.expand_path.to_s) }
    unless managed_orphans.empty?
      warn "Managed posts no longer have an opted-in source. Review manually before removal:"
      managed_orphans.each { |path| warn "  - #{path.relative_path_from(@root)}" }
      exit 1
    end

    puts "Synced #{written} posts; #{unchanged} unchanged."
    puts "Next: docker compose up -d --build"
  end

  def vault_audit
    cli = Pathname.new("/usr/local/bin/obsidian")
    abort "Obsidian CLI is not registered at #{cli}" unless cli.executable?

    vault_argument = "vault=#{@vault.basename}"
    commands = [
      ["unresolved", "verbose"],
      ["orphans"],
      ["files", "folder=#{@drafts_dir}", "total"]
    ]
    commands.each do |command|
      puts "\n$ obsidian #{vault_argument} #{command.join(" ")}"
      success = system(cli.to_s, vault_argument, *command)
      abort "Obsidian CLI audit failed. Open Obsidian and retry." unless success
    end
  end

  def validate
    all_notes = vault_notes
    exported = draft_notes.select { |note| truthy?(note.data["blog_publish"]) }
    lookup, errors = note_lookup(all_notes)

    exported_paths = exported.map(&:path).to_h { |path| [path.expand_path.to_s, true] }
    slug_owners = {}
    exported.each do |note|
      if note.body.include?(EM_DASH) || JSON.generate(note.data).include?(EM_DASH)
        errors << "#{note.relative_path}: contains an em dash; rewrite it with a colon, comma, semicolon, or parentheses"
      end
      REQUIRED_PROPERTIES.each do |property|
        value = note.data[property]
        errors << "#{note.relative_path}: missing #{property}" if value.nil? || value.to_s.strip.empty?
      end
      status = note.data["status"].to_s
      errors << "#{note.relative_path}: status must be #{ALLOWED_STATUSES.join(", ")}" unless ALLOWED_STATUSES.include?(status)

      begin
        normalized_date(note.data["date"])
      rescue ArgumentError
        errors << "#{note.relative_path}: date must be YYYY-MM-DD"
      end

      slug = note_slug(note)
      errors << "#{note.relative_path}: invalid slug '#{slug}'" unless slug.match?(/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/)
      if slug_owners.key?(slug)
        errors << "Duplicate public slug '#{slug}' in #{note.relative_path} and #{slug_owners[slug].relative_path}"
      else
        slug_owners[slug] = note
      end

      each_wikilink(note.body) do |raw_reference|
        destination, = raw_reference.split("|", 2).map(&:strip)
        target_name, target_section = destination.split("#", 2).map { |part| part&.strip }
        target = target_name.to_s.empty? ? note : resolve_note(lookup, target_name)
        if target.nil?
          errors << "#{note.relative_path}: unresolved wikilink [[#{raw_reference}]]"
          next
        end
        canonical_name = target.path.basename(".md").to_s
        if !target_name.to_s.empty? && target_name != canonical_name
          errors << "#{note.relative_path}: '#{target_name}' is an alias/title target; run bin/blog normalize-links to use Obsidian-native [[#{canonical_name}|#{target_name}]] syntax"
        end
        unless exported_paths[target.path.expand_path.to_s]
          errors << "#{note.relative_path}: public draft links to private note '#{target_name}'"
        end
        if target_section && !target_section.empty? && !heading_anchors(target.body).include?(slugify(target_section))
          errors << "#{note.relative_path}: missing section '#{target_section}' in #{target.relative_path}"
        end
      end

      rewrite_embeds(note, slug, copy: false, errors: errors)
    end

    { exported: exported, errors: errors.uniq }
  end

  def export_data(note, slug)
    data = note.data.dup
    data.delete("blog_publish")
    data.delete("obsidian_source")
    data.delete("obsidian_sha256")
    data["slug"] = slug
    data["date"] = normalized_date(data["date"])
    data["sitemap"] = false unless data["status"].to_s == "published"
    data.delete("sitemap") if data["status"].to_s == "published" && data["sitemap"] == false
    data["obsidian_source"] = note.relative_path
    data["obsidian_sha256"] = Digest::SHA256.file(note.path).hexdigest
    data
  end

  def rewrite_embeds(note, slug, copy:, errors: [])
    transform_outside_code(note.body) do |segment|
      segment.gsub(EMBED_PATTERN) do
        raw = Regexp.last_match(1).strip
        target, display = raw.split("|", 2).map { |part| part&.strip }
        target = target.split("#", 2).first
        extension = File.extname(target).downcase
        unless IMAGE_EXTENSIONS.include?(extension) || DOWNLOAD_EXTENSIONS.include?(extension)
          errors << "#{note.relative_path}: embedded note/transclusion '#{raw}' is private; embed only an attachment"
          next Regexp.last_match(0)
        end

        source = resolve_attachment(target)
        unless source
          errors << "#{note.relative_path}: missing attachment '#{target}'"
          next Regexp.last_match(0)
        end

        filename = "#{slugify(File.basename(target, extension))}#{extension}"
        relative_asset = Pathname.new(@config.fetch("assets_dir", "assets/notes")).join(slug, filename)
        destination = @root.join(relative_asset)
        if copy
          FileUtils.mkdir_p(destination.dirname)
          FileUtils.cp(source, destination) unless destination.exist? && FileUtils.compare_file(source, destination)
        end
        url = "/#{relative_asset.to_s}"
        label = display.to_s.match?(/\A\d+(?:x\d+)?\z/) || display.to_s.empty? ? File.basename(target, extension).tr("-_", " ") : display
        IMAGE_EXTENSIONS.include?(extension) ? "![#{label}](#{url})" : "[#{label}](#{url})"
      end
    end
  end

  def each_wikilink(content)
    transform_outside_code(content) do |segment|
      segment.scan(WIKILINK_PATTERN) { |capture| yield capture.first.strip }
      segment
    end
  end

  def transform_outside_code(content)
    in_fence = false
    fence_character = nil
    content.lines.map do |line|
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
      next line if in_fence

      line.split(/(`+[^`]*`+)/).map.with_index do |segment, index|
        index.odd? ? segment : yield(segment)
      end.join
    end.join
  end

  def resolve_attachment(target)
    direct = @vault.join(target)
    return direct if direct.file?

    preferred = @vault.join(@attachments_dir, File.basename(target))
    return preferred if preferred.file?

    candidates = Dir[@vault.join("**", File.basename(target)).to_s].map { |path| Pathname.new(path) }.select(&:file?)
    candidates.one? ? candidates.first : nil
  end

  def resolve_note(lookup, name)
    normalized_keys(name).each { |key| return lookup[key] if lookup.key?(key) }
    nil
  end

  def note_lookup(notes)
    lookup = {}
    errors = []
    notes.each do |note|
      note_keys(note).each do |key|
        normalized_keys(key).each do |normalized|
          next if normalized.empty?
          if lookup.key?(normalized) && lookup[normalized].path != note.path
            errors << "Duplicate note name or alias '#{key}' in #{note.relative_path} and #{lookup[normalized].relative_path}"
          else
            lookup[normalized] = note
          end
        end
      end
    end
    [lookup, errors.uniq]
  end

  def note_keys(note)
    [note.path.basename(".md").to_s, note.data["title"], note.data["slug"], *Array(note.data["aliases"])].compact
  end

  def normalized_keys(value)
    text = value.to_s.strip.downcase
    [text, slugify(text)].uniq
  end

  def heading_anchors(content)
    anchors = []
    transform_outside_code(content) do |segment|
      segment.lines.each do |line|
        heading = line.match(HEADING_PATTERN)
        anchors << slugify(clean_heading(heading[2])) if heading
      end
      segment
    end
    anchors
  end

  def clean_heading(value)
    value.to_s.gsub(/\[([^\]]+)\]\([^\)]+\)/, '\\1').gsub(/[*_`]/, "").strip
  end

  def draft_notes
    directory = @vault.join(@drafts_dir)
    return [] unless directory.directory?

    Dir[directory.join("**", "*.md").to_s].sort.map do |path|
      parse_note(Pathname.new(path), Pathname.new(path).relative_path_from(@vault).to_s)
    end
  end

  def vault_notes
    Dir[@vault.join("**", "*.md").to_s].sort.reject do |path|
      relative = Pathname.new(path).relative_path_from(@vault).each_filename.to_a
      relative.any? { |part| part.start_with?(".") } || relative.first == @templates_dir
    end.map do |path|
      parse_note(Pathname.new(path), Pathname.new(path).relative_path_from(@vault).to_s)
    end
  end

  def managed_posts
    Dir[@posts_dir.join("*.md").to_s].each_with_object([]) do |path, managed|
      note = parse_note(Pathname.new(path), Pathname.new(path).basename.to_s)
      managed << Pathname.new(path) unless note.data["obsidian_source"].to_s.empty?
    end
  end

  def parse_note(path, relative_path)
    raw = path.read
    if (match = raw.match(/\A---\s*\n(.*?)\n---\s*\n?(.*)\z/m))
      data = YAML.safe_load(match[1], permitted_classes: [Date, Time], aliases: true) || {}
      body = match[2]
    else
      data = {}
      body = raw
    end
    Note.new(path: path, relative_path: relative_path, data: stringify_keys(data), body: body)
  rescue Psych::SyntaxError => error
    abort "Invalid YAML in #{path}: #{error.message}"
  end

  def serialize_note(data, body)
    yaml = YAML.dump(data).sub(/\A---\s*\n/, "")
    "---\n#{yaml}---\n\n#{body.sub(/\A\s+/, "")}"
  end

  def write_note(path, data, body)
    FileUtils.mkdir_p(path.dirname)
    path.write(serialize_note(data, body))
  end

  def write_unless_exists(path, content)
    return if path.exist?

    FileUtils.mkdir_p(path.dirname)
    path.write(content)
  end

  def load_yaml(path)
    stringify_keys(YAML.safe_load(path.read, permitted_classes: [Date, Time], aliases: true) || {})
  rescue Psych::SyntaxError => error
    abort "Invalid YAML in #{path}: #{error.message}"
  end

  def stringify_keys(hash)
    hash.to_h.transform_keys(&:to_s)
  end

  def required_config(key)
    value = @config[key]
    abort "Missing '#{key}' in #{@config_path}" if value.to_s.empty?
    value
  end

  def note_slug(note)
    value = note.data["slug"].to_s
    value = note.path.basename(".md").to_s if value.empty?
    slugify(value)
  end

  def slugify(value)
    value.to_s.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/-+/, "-").gsub(/\A-+|-+\z/, "")
  end

  def normalized_date(value)
    value = value.iso8601 if value.respond_to?(:iso8601)
    Date.iso8601(value.to_s).iso8601
  end

  def truthy?(value)
    value == true || %w[true yes 1].include?(value.to_s.downcase)
  end

  def generated_notice(note)
    "<!-- Generated from Obsidian: #{note.relative_path}. Edit the vault source, then run bin/blog sync. -->\n\n"
  end

  def configure_obsidian
    obsidian = @vault.join(".obsidian")
    FileUtils.mkdir_p(obsidian)
    app_path = obsidian.join("app.json")
    app = app_path.file? ? JSON.parse(app_path.read) : {}
    app["attachmentFolderPath"] = @attachments_dir
    app["newLinkFormat"] = "shortest"
    app["alwaysUpdateLinks"] = true
    app_path.write(JSON.pretty_generate(app) + "\n")
    obsidian.join("templates.json").write(JSON.pretty_generate({ "folder" => @templates_dir }) + "\n")
  end

  def blog_template
    <<~MARKDOWN
      ---
      title: "{{title}}"
      slug:
      aliases: []
      description:
      date: "{{date}}"
      updated: "{{date}}"
      status: todo
      content_type: essay
      tags: []
      people: []
      next_step: "Define the claim, evidence, and first discriminating test."
      math: false
      p5: false
      blog_publish: false
      ---

      #{article_body}
    MARKDOWN
  end

  def article_body
    <<~MARKDOWN
      > **Claim:** State the narrow claim in one sentence.

      ## The anomaly

      Begin with the observation, result, or contradiction that earns the question.

      ## The mechanism

      Define terms, show dynamics, and distinguish evidence from inference.

      ## Where the connection works

      Link the exact related argument with `[[another-draft#Relevant section|a meaningful label]]`.

      ## Where the connection breaks

      State limits, counterexamples, and the strongest objection.

      ## An experiment that could change my mind

      Describe a reproducible test or discriminating prediction.

      ## References

      Use stable primary sources, DOI links, and source notes from `10 Sources`.
    MARKDOWN
  end

  def source_template
    <<~MARKDOWN
      ---
      title: "{{title}}"
      kind: source
      source_type:
      source:
      doi:
      author:
      published:
      verified: "{{date}}"
      tags: [source]
      ---

      ## Claim relevant to this project

      ## Evidence and method

      ## Variables, assumptions, and sample

      ## Verified quotations and locators

      ## Limitations and counterevidence

      ## Connections

      ## Citation
    MARKDOWN
  end

  def reference_intake_template
    <<~MARKDOWN
      ---
      title: "{{title}}"
      intake_type: reference
      review_status: unreviewed
      source_type:
      source:
      doi:
      author:
      published:
      captured: "{{date}}"
      candidate_draft:
      tags: [intake, reference]
      ---

      ## Why this may matter

      ## Claims to verify

      ## Primary source to locate

      ## Triage decision

      Keep this note in `00 Inbox/References` until its provenance, claims, and
      usefulness have been checked. Create a clean source note in `10 Sources`
      only after verification.
    MARKDOWN
  end

  def ai_intake_template
    <<~MARKDOWN
      ---
      title: "{{title}}"
      intake_type: ai
      review_status: unreviewed
      model:
      captured: "{{date}}"
      candidate_draft:
      tags: [intake, ai]
      ---

      ## Prompt or task

      ## Raw output

      ## Claims and citations requiring independent verification

      ## Useful questions

      ## Human decision

      AI-generated text stays in `00 Inbox/AI Intake`. Do not move its prose
      directly into `10 Sources`, `20 Concepts`, or `30 Drafts`. Verify claims
      from primary sources, then write the synthesis in your own words.
    MARKDOWN
  end

  def concept_template
    <<~MARKDOWN
      ---
      title: "{{title}}"
      kind: concept
      aliases: []
      tags: []
      updated: "{{date}}"
      ---

      ## Working definition

      ## Competing definitions

      ## Mechanism or formal object

      ## Evidence and examples

      ## Counterexamples and limits

      ## Open questions

      ## Source notes

      ## Candidate drafts
    MARKDOWN
  end

  def publishing_board
    <<~MARKDOWN
      # Publishing board

      This read-only board is generated from properties on notes in
      `#{@drafts_dir}`. Change `status`, `next_step`, and `blog_publish` in the
      draft itself. Do not drag or duplicate cards.

      - `blog_publish: false` means private.
      - `blog_publish: true` means the note may appear on the public board.
      - The website changes only after `bin/blog sync`, review, merge, and deploy.

      ## Todo

      ```dataview
      TABLE WITHOUT ID
        file.link AS Draft,
        content_type AS Type,
        next_step AS "Next step",
        choice(blog_publish, "Public roadmap", "Private") AS Visibility,
        updated AS Updated
      FROM "#{@drafts_dir}"
      WHERE status = "todo"
      SORT updated DESC, file.name ASC
      ```

      ## In progress

      ```dataview
      TABLE WITHOUT ID
        file.link AS Draft,
        content_type AS Type,
        next_step AS "Next step",
        choice(blog_publish, "Public roadmap", "Private") AS Visibility,
        updated AS Updated
      FROM "#{@drafts_dir}"
      WHERE status = "in-progress"
      SORT updated DESC, file.name ASC
      ```

      ## Published

      ```dataview
      TABLE WITHOUT ID
        file.link AS Draft,
        content_type AS Type,
        next_step AS "Next step",
        choice(blog_publish, "Public", "Private") AS Visibility,
        updated AS Updated
      FROM "#{@drafts_dir}"
      WHERE status = "published"
      SORT updated DESC, file.name ASC
      ```
    MARKDOWN
  end

  def vault_guide
    <<~MARKDOWN
      # Vault guide

      The vault is a promotion pipeline. Material moves forward only after a
      human decision. Folder location communicates evidence maturity.

      The Inbox-only AI rule applies to research material, summaries, outlines,
      citations, equations, code, and candidate article prose. Operational
      files such as this guide, templates, and the Publishing Board stay in
      their functional locations.

      ## Folder responsibilities

      - `00 Inbox/Web Clips`: raw browser captures and clipped pages.
      - `00 Inbox/References`: DOI links, paper leads, bibliographies, PDFs to
        inspect, and other unverified reference candidates.
      - `00 Inbox/AI Intake`: every AI-generated summary, outline, suggestion,
        citation lead, or candidate passage. AI output does not go directly
        into source, concept, or draft notes.
      - `10 Sources`: one clean, human-verified record per source. Record what
        the source establishes, its method, limitations, exact citation, and
        any quotation locator. This is not a clip archive.
      - `20 Concepts`: private, human-authored synthesis across verified
        sources. Record definitions, mechanisms, disagreements, limits, and
        questions. Do not paste source or AI prose here.
      - `#{@drafts_dir}`: canonical article prose and front matter. This is the
        only folder the compiler considers for publication. Keep the canonical
        source here even after `status: published`.
      - `40 Published`: post-publication corrections, response notes, release
        notes, and follow-up research. Do not move the canonical article source
        here because the compiler expects it in `#{@drafts_dir}`.
      - `#{@templates_dir}`: approved templates for each stage.
      - `#{@attachments_dir}`: local images and supported documents. A file is
        copied to the site only when an opted-in draft embeds it explicitly.

      ## Publishing boundary

      `blog_publish: false` is the default. The compiler rejects public wikilinks to private notes, so a source clip or private concept cannot leak through a link. Transcluded notes are also rejected; only explicit image or document attachments are copied.

      ## Daily loop

      1. Capture every external or machine-generated input in `00 Inbox`.
      2. Triage relevance, provenance, evidence type, and the claim to verify.
      3. Locate and read the primary source when possible.
      4. Create a clean verified note in `10 Sources`; keep raw intake in Inbox.
      5. Write reusable synthesis in your own words in `20 Concepts`.
      6. Create or update an article in `#{@drafts_dir}`.
      7. Change `status` in the draft. `Publishing Board.md` updates
         automatically from those properties.
      8. Write normal Obsidian wikilinks, including exact section links.
      9. Set `blog_publish: true` only when the full note may leave the vault.
      10. Run normalization, validation, sync, preview, Git review, and deploy.

      In Web Clipper, set the destination folder to `00 Inbox/Web Clips`.
      Unverified references go to `00 Inbox/References`. AI-generated material
      goes to `00 Inbox/AI Intake`. Keep provenance with every intake item.
    MARKDOWN
  end
end

ObsidianBlog.new.run(ARGV)

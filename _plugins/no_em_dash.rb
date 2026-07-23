# frozen_string_literal: true

require "pathname"

module ConnectedNotebook
  module NoEmDash
    CHARACTER = "\u2014"
    TEXT_EXTENSIONS = %w[.css .html .js .json .svg .txt .xml].freeze

    Jekyll::Hooks.register :site, :post_write do |site|
      offenders = Dir.glob(File.join(site.dest, "**", "*")).filter_map do |path|
        next unless File.file?(path)
        next unless TEXT_EXTENSIONS.include?(File.extname(path).downcase)
        next unless File.read(path).include?(CHARACTER)

        Pathname.new(path).relative_path_from(Pathname.new(site.dest)).to_s
      end

      next if offenders.empty?

      raise Jekyll::Errors::FatalException,
            "Generated site contains a forbidden em dash in: #{offenders.join(', ')}"
    end
  end
end

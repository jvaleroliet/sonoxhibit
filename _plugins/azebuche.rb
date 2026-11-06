# AZEBUCHE build helpers.
#
# 1. Before Jekyll reads the site, dither new or changed photos from
#    src/azebuche/raw into src/azebuche/dithered (tools/azebuche/dither.py).
# 2. Leave recordings marked `draft: true` out of the site.
# 3. Keep line breaks in lyrics: a new line in the text box is a new line
#    on the page (Markdown would otherwise join them).
# 4. Write the index page weight (HTML, CSS, fonts, drawing; photos apart) into its footer.

require "open3"
require "uri"

module Azebuche
  RAW      = "src/azebuche/raw"
  DITHERED = "src/azebuche/dithered"
  SCRIPT   = "tools/azebuche/dither.py"

  def self.dither(site)
    raw = File.join(site.source, RAW)
    return unless Dir.exist?(raw)

    pythons = Gem.win_platform? ? %w(python py python3) : %w(python3 python)
    pythons.each do |py|
      begin
        out, status = Open3.capture2e(py, File.join(site.source, SCRIPT), raw, File.join(site.source, DITHERED))
      rescue SystemCallError
        next
      end
      out.each_line { |l| Jekyll.logger.info "Azebuche:", "dithered #{l.strip}" }
      return if status.success?
      raise "Azebuche: dither.py failed:\n#{out}"
    end
    raise "Azebuche: Python 3 with Pillow is needed to dither images (pip install Pillow)"
  end

  BLOCK = /\A\s*([#>|]|[-*+]\s|\d+[.)]\s)/

  def self.keep_line_breaks(text)
    lines = text.split("\n", -1)
    lines.each_with_index.map do |line, i|
      nxt = lines[i + 1]
      next line if nxt.nil? || line.strip.empty? || nxt.strip.empty?
      next line if line =~ BLOCK || nxt =~ BLOCK
      line.sub(/\\?\s*\z/, "  ")
    end.join("\n")
  end

  def self.kb(bytes)
    "#{(bytes / 1024.0).round} KB"
  end
end

Jekyll::Hooks.register :site, :after_reset do |site|
  Azebuche.dither(site)
end

Jekyll::Hooks.register :site, :post_read do |site|
  site.collections["azebuche"]&.docs&.reject! { |doc| doc.data["draft"] }
end

Jekyll::Hooks.register :azebuche, :pre_render do |doc|
  doc.content = Azebuche.keep_line_breaks(doc.content)
end

Jekyll::Hooks.register :pages, :post_render do |page|
  next unless page.output&.include?("<!--azb-weight-->")

  source = page.site.source
  css = File.size(File.join(source, "azebuche/azebuche.css"))
  fonts = Dir[File.join(source, "azebuche/fonts/*.woff2")].sum { |f| File.size(f) }
  drawing = %w[olive-branch.png favicon.png].sum { |f| File.size(File.join(source, "azebuche", f)) }
  images = page.output.scan(%r{src="/(src/azebuche/dithered/[^"]+\.png)"}).flatten.uniq
  img = images.sum { |p| File.size?(File.join(source, URI.decode_uri_component(p))) || 0 }
  html = page.output.bytesize

  page.output = page.output.sub(
    "<!--azb-weight-->",
    "#{Azebuche.kb(html + css + fonts + drawing)} of HTML, CSS, fonts and the olive drawing. " \
    "Photos load only when an entry is opened (#{Azebuche.kb(img)} in total)."
  )
end

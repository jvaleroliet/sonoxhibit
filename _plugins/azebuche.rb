# AZEBUCHE build helpers.
#
# 1. Before Jekyll reads the site, dither new or changed photos from
#    src/azebuche/raw into src/azebuche/dithered (tools/azebuche/dither.py).
# 2. Leave recordings marked `draft: true` out of the site.
# 3. Write the index page weight into its footer.

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

Jekyll::Hooks.register :pages, :post_render do |page|
  next unless page.output&.include?("<!--azb-weight-->")

  source = page.site.source
  css = File.size(File.join(source, "azebuche/azebuche.css"))
  images = page.output.scan(%r{src="/(src/azebuche/dithered/[^"]+\.png)"}).flatten.uniq
  img = images.sum { |p| File.size?(File.join(source, URI.decode_uri_component(p))) || 0 }
  html = page.output.bytesize

  page.output = page.output.sub(
    "<!--azb-weight-->",
    "#{Azebuche.kb(html + css)} of HTML and CSS. " \
    "Photos load only when an entry is opened (#{Azebuche.kb(img)} in total)."
  )
end

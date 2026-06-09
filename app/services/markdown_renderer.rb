# Renders database-authored article bodies (Markdown) to safe HTML:
#
#   1. CommonMark -> HTML in *safe* mode, so raw HTML (e.g. <script>) is dropped
#      rather than passed through. commonmarker's built-in highlighter is
#      disabled so code blocks come out as plain <pre lang="..."><code>.
#   2. Fenced code blocks are re-highlighted through Rouge (CodeHighlighter) so
#      database and file-backed articles share one syntax theme.
#   3. The result is sanitized against an explicit allow-list as defense in depth.
#
# File-backed articles never pass through here — they render trusted ERB.
module MarkdownRenderer
  COMMONMARKER_OPTIONS = {
    render: { unsafe: false },
    extension: { table: true, strikethrough: true, autolink: true, tagfilter: true }
  }.freeze

  # Tags/attributes that survive sanitization: standard Markdown output plus the
  # <pre>/<code>/<span class> that Rouge emits.
  ALLOWED_TAGS = %w[
    p br hr h1 h2 h3 h4 h5 h6 blockquote
    ul ol li strong em del code pre span a img
    table thead tbody tr th td sup sub
  ].freeze
  ALLOWED_ATTRIBUTES = %w[class data-language href src alt title].freeze

  module_function

  def render(text)
    return "".html_safe if text.blank?

    html = Commonmarker.to_html(text, options: COMMONMARKER_OPTIONS, plugins: { syntax_highlighter: nil })
    html = highlight_code_blocks(html)
    sanitizer.sanitize(html, tags: ALLOWED_TAGS, attributes: ALLOWED_ATTRIBUTES).html_safe
  end

  def highlight_code_blocks(html)
    fragment = Nokogiri::HTML5.fragment(html)
    fragment.css("pre > code").each do |code|
      pre = code.parent
      replacement = CodeHighlighter.highlight(code.text, language: pre["lang"])
      pre.replace(Nokogiri::HTML5.fragment(replacement))
    end
    fragment.to_html
  end

  def sanitizer
    @sanitizer ||= Rails::HTML5::SafeListSanitizer.new
  end
end

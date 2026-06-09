# Server-side syntax highlighting via Rouge. Shared by MarkdownRenderer
# (database articles) and CodeBlockComponent (file-backed ERB articles) so both
# render paths emit identical markup and use the same theme CSS
# (app/assets/stylesheets/syntax.css).
#
# Regenerate syntax.css (Github light + dark-scoped) with:
#
#   light = Rouge::Themes::Github.mode(:light)
#   dark  = Rouge::Themes::Base16.mode(:dark)
#   File.write("app/assets/stylesheets/syntax.css",
#     light.render(scope: ".highlight") + "\n" + dark.render(scope: ".dark .highlight"))
module CodeHighlighter
  FORMATTER = Rouge::Formatters::HTML.new

  module_function

  # Returns an html_safe <pre class="highlight">…</pre> string.
  def highlight(source, language: nil)
    inner = FORMATTER.format(lexer_for(language).lex(source.to_s))
    label = ERB::Util.h(language.to_s.presence)
    %(<pre class="highlight" data-language="#{label}"><code>#{inner}</code></pre>).html_safe
  end

  # Resolves a Rouge lexer instance, falling back to plain text for unknown or
  # missing languages.
  def lexer_for(language)
    found = language.present? && Rouge::Lexer.find(language.to_s.downcase)
    (found || Rouge::Lexers::PlainText).new
  end
end

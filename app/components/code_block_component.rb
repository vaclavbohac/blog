# Renders a syntax-highlighted code block in file-backed (ERB) articles, e.g.
#
#   <%= render CodeBlockComponent.new(language: "elixir", source: <<~ELIXIR) %>
#     defmodule Greeter do
#       def hello(name), do: "Hello, #{name}!"
#     end
#   ELIXIR
#
# Highlighting goes through the shared CodeHighlighter so output matches the
# Markdown render path exactly.
class CodeBlockComponent < ApplicationComponent
  def initialize(source:, language: nil)
    @source = source
    @language = language
  end

  def call
    CodeHighlighter.highlight(@source, language: @language)
  end
end

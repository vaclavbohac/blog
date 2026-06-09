require "test_helper"

class MarkdownRendererTest < ActiveSupport::TestCase
  test "renders Markdown to HTML" do
    html = MarkdownRenderer.render("## Heading\n\nA **bold** word.")

    assert_includes html, "<h2"
    assert_includes html, "<strong>bold</strong>"
  end

  test "highlights fenced code blocks through Rouge" do
    html = MarkdownRenderer.render("```elixir\ndefmodule Foo do\nend\n```")

    assert_includes html, %(data-language="elixir")
    assert_includes html, %(<span class="k">defmodule</span>)
  end

  test "strips script tags and other raw HTML" do
    html = MarkdownRenderer.render("Hello\n\n<script>alert(1)</script>\n")

    assert_not_includes html, "<script"
    assert_not_includes html, "alert(1)"
  end

  test "returns a blank html_safe string for empty input" do
    assert_equal "", MarkdownRenderer.render(nil)
    assert_equal "", MarkdownRenderer.render("")
    assert_predicate MarkdownRenderer.render(""), :html_safe?
  end
end

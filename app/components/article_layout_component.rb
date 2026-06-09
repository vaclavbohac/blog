# Single-article page: a back link, title + date header, and the article body
# passed as a content block. Mirrors Spotlight's `ArticleLayout`.
#
#   <%= render ArticleLayoutComponent.new(post: @post) do %>
#     <%= simple_format(@post.body) %>
#   <% end %>
class ArticleLayoutComponent < ApplicationComponent
  def initialize(post:, back_path:)
    @post = post
    @back_path = back_path
  end

  def published_label
    @post.published_at.strftime("%B %-d, %Y")
  end

  def published_datetime
    @post.published_at.iso8601
  end
end

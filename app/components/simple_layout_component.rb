# A page header (title + intro) above a content block, wrapped in a Container.
# Mirrors Spotlight's `SimpleLayout`.
#
#   <%= render SimpleLayoutComponent.new(title: "Writing…", intro: "All of my…") do %>
#     … page content …
#   <% end %>
class SimpleLayoutComponent < ApplicationComponent
  def initialize(title:, intro:)
    @title = title
    @intro = intro
  end
end

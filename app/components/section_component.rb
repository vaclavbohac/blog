# A titled content section: a heading column beside its content, with a left
# border on md+ screens. Mirrors Spotlight's `Section`.
#
#   <%= render SectionComponent.new(title: "Workstation") do %>
#     … content …
#   <% end %>
class SectionComponent < ApplicationComponent
  def initialize(title:)
    @title = title
  end

  def heading_id
    "section-#{@title.parameterize}"
  end
end

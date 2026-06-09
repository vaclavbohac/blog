# A hover-highlighted content card. Compound: use the slots for the title,
# eyebrow, description and call-to-action. Mirrors Spotlight's `Card`.
#
#   <%= render CardComponent.new do |card| %>
#     <% card.with_title(href: post_path(post)) { post.title } %>
#     <% card.with_eyebrow(as: :time, decorate: true) { post.created_at.to_date } %>
#     <% card.with_description { post.perex } %>
#     <% card.with_cta { "Read article" } %>
#   <% end %>
class CardComponent < ApplicationComponent
  renders_one :eyebrow, "CardComponent::EyebrowComponent"
  renders_one :title, "CardComponent::TitleComponent"
  renders_one :description, "CardComponent::DescriptionComponent"
  renders_one :cta, "CardComponent::CtaComponent"

  def initialize(as: :div, class_name: nil, **attrs)
    @as = as
    @class_name = class_name
    @attrs = attrs
  end

  def classes
    [ "group relative flex flex-col items-start", @class_name ].compact.join(" ")
  end
end

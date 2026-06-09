# Card title. With `href:`, the whole card becomes clickable via Card.Link.
# Mirrors Spotlight's `Card.Title`.
class CardComponent::TitleComponent < ApplicationComponent
  def initialize(as: :h2, href: nil, **attrs)
    @as = as
    @href = href
    @attrs = attrs
  end
end

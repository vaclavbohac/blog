# The hover-fill background + full-card click target used by a linked title.
# Mirrors Spotlight's `Card.Link`.
class CardComponent::LinkComponent < ApplicationComponent
  def initialize(href:, **attrs)
    @href = href
    @attrs = attrs
  end
end

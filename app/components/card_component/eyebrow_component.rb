# Small label above the card (e.g. a date). `decorate: true` adds the leading
# tick mark. Mirrors Spotlight's `Card.Eyebrow`.
class CardComponent::EyebrowComponent < ApplicationComponent
  def initialize(as: :p, decorate: false, class_name: nil, **attrs)
    @as = as
    @decorate = decorate
    @class_name = class_name
    @attrs = attrs
  end

  def classes
    [
      "relative z-10 order-first mb-3 flex items-center text-sm text-zinc-400 dark:text-zinc-500",
      ("pl-3.5" if @decorate),
      @class_name
    ].compact.join(" ")
  end
end

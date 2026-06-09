# Renders a styled button, or an <a> when `href:` is given. Mirrors Spotlight's `Button`.
#
# Pass the label as a do/end block (a brace `{ }` block binds to `.new`, not `render`):
#   <%= render ButtonComponent.new(type: "submit") do %>Join<% end %>
#   <%= render ButtonComponent.new(href: "#", variant: :secondary, class_name: "w-full") do %>Download CV<% end %>
class ButtonComponent < ApplicationComponent
  VARIANTS = {
    primary: "bg-zinc-800 font-semibold text-zinc-100 hover:bg-zinc-700 active:bg-zinc-800 active:text-zinc-100/70 dark:bg-zinc-700 dark:hover:bg-zinc-600 dark:active:bg-zinc-700 dark:active:text-zinc-100/70",
    secondary: "bg-zinc-50 font-medium text-zinc-900 hover:bg-zinc-100 active:bg-zinc-100 active:text-zinc-900/60 dark:bg-zinc-800/50 dark:text-zinc-300 dark:hover:bg-zinc-800 dark:hover:text-zinc-50 dark:active:bg-zinc-800/50 dark:active:text-zinc-50/70"
  }.freeze

  def initialize(variant: :primary, href: nil, class_name: nil, **attrs)
    @variant = variant.to_sym
    @href = href
    @class_name = class_name
    @attrs = attrs
  end

  def classes
    [
      "inline-flex items-center gap-2 justify-center rounded-md py-2 px-3 text-sm outline-offset-2 transition active:transition-none",
      VARIANTS.fetch(@variant),
      @class_name
    ].compact.join(" ")
  end
end

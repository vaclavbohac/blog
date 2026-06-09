# Full page container = Outer wrapping Inner. The default for page content.
# Mirrors Spotlight's `Container`.
class ContainerComponent < ApplicationComponent
  def initialize(class_name: nil, **attrs)
    @class_name = class_name
    @attrs = attrs
  end
end

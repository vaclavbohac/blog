# Outer half of the page container: horizontal gutters + max width.
# Mirrors Spotlight's `ContainerOuter`.
class Container::OuterComponent < ApplicationComponent
  def initialize(class_name: nil, **attrs)
    @class_name = class_name
    @attrs = attrs
  end
end

# Inner half of the page container: narrower max width + padding.
# Mirrors Spotlight's `ContainerInner`.
class Container::InnerComponent < ApplicationComponent
  def initialize(class_name: nil, **attrs)
    @class_name = class_name
    @attrs = attrs
  end
end

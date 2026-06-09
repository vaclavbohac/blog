# Previous/next navigation between published articles in a series, shown at the
# foot of an article. Renders nothing for standalone posts or at the ends of a
# series.
class SeriesNavComponent < ApplicationComponent
  def initialize(post:)
    @previous = post.previous_in_series
    @next = post.next_in_series
  end

  def render?
    @previous.present? || @next.present?
  end
end

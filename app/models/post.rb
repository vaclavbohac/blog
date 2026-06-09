class Post < ApplicationRecord
  # Published posts (released on or before now), most recent first.
  scope :published, -> { where("published_at <= ?", Time.current).order(published_at: :desc) }
  scope :homepage_posts, -> { published }

  # published_at is intentionally optional: a nil value marks an unpublished draft.
  validates :title, :perex, :body, presence: true

  def published?
    published_at.present? && published_at <= Time.current
  end
end

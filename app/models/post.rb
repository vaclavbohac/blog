class Post < ApplicationRecord
  belongs_to :series, optional: true

  # Published posts (released on or before now), most recent first.
  scope :published, -> { where("published_at <= ?", Time.current).order(published_at: :desc) }
  scope :homepage_posts, -> { published }

  # published_at is intentionally optional: a nil value marks an unpublished draft.
  validates :title, :perex, presence: true
  # body holds Markdown for database-authored articles. File-backed articles
  # (content_path set) render an ERB template instead, so they have no body.
  validates :body, presence: true, unless: :file_backed?

  def published?
    published_at.present? && published_at <= Time.current
  end

  # True when the article's content comes from an ERB template on disk
  # (app/views/<content_path>) rather than the Markdown body column.
  def file_backed?
    content_path.present?
  end

  # Previous/next published article in the same series, by position. Returns nil
  # when the post is standalone or at an end of the series.
  def previous_in_series
    return nil unless series && position
    series.posts.published.where(position: ...position).reorder(position: :desc).first
  end

  def next_in_series
    return nil unless series && position
    series.posts.published.where(position: (position + 1)..).reorder(position: :asc).first
  end
end

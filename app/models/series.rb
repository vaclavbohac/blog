class Series < ApplicationRecord
  # Articles in the series, in reading order. Deleting a series leaves its posts
  # intact but unlinked (a post can outlive its series).
  has_many :posts, -> { order(:position) }, dependent: :nullify, inverse_of: :series

  validates :title, presence: true

  # Series shown in admin/selectors, most recent first.
  scope :ordered, -> { order(created_at: :desc) }
end

class WorkExperience < ApplicationRecord
  # Most recent role first; ongoing roles (no end date) sort to the top.
  scope :ordered, -> { order(started_on: :desc) }

  validates :company, :role, :logo, :started_on, presence: true
  validate :ended_on_after_started_on

  def ongoing?
    ended_on.nil?
  end

  private
    def ended_on_after_started_on
      return if ended_on.blank? || started_on.blank?
      return if ended_on >= started_on

      errors.add(:ended_on, "must be on or after the start date")
    end
end

class Project < ApplicationRecord
  validates :name, :logo, :description, presence: true
end

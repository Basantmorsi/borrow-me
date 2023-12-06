class Tool < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  scope :search_by_name, ->(query) { where('name ILIKE ?', "%#{query}%") }
end

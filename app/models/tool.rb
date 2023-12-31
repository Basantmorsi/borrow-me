class Tool < ApplicationRecord
  belongs_to :user
  has_many :tool_requests
  has_many :messages
  validates :name, presence: true
  scope :search_by_name, ->(query) { where('name ILIKE ?', "%#{query}%") }
  has_one_attached :photo
end

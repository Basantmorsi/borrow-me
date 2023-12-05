class Tool < ApplicationRecord
  belongs_to :user_id
  validates :name, presence: true
end

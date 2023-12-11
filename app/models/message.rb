class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
  belongs_to :tool, optional: true
  belongs_to :request, optional: true

  validates :content, presence: true, length: {minimum: 2, maximum: 1000}

  def topic
    tool_id.nil? ? request.message : tool.name
  end
end

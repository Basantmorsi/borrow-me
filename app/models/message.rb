class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
  belongs_to :tool, optional: true
  belongs_to :request, optional: true

  validates :content, presence: true, length: {minimum: 2, maximum: 1000}

  def topic
    if(tool_id.nil? && !request_id.nil?)
      request.message
    elsif (request_id.nil? && !tool_id.nil?)
      tool.name
    end
  end
end

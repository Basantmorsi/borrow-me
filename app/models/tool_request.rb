class ToolRequest < ApplicationRecord
  belongs_to :user
  belongs_to :tool_id
end

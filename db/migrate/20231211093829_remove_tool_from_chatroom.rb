class RemoveToolFromChatroom < ActiveRecord::Migration[7.1]
  def change
    remove_column :chatrooms, :tool_id
  end
end

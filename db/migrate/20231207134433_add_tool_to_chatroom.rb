class AddToolToChatroom < ActiveRecord::Migration[7.1]
  def change
    add_reference :chatrooms, :tool, foreign_key: true
  end
end

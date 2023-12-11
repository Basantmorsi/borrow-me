class AddcolumnToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :tool, foreign_key: true
    add_reference :messages, :request, foreign_key: true
  end
end

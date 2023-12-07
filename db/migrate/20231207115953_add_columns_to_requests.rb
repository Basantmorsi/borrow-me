class AddColumnsToRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :requests, :user, null: false, foreign_key: true
  end
end

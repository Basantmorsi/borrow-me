class CreateChatrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :chatrooms do |t|
      t.string :name
      t.references :sender
      t.references :recipient

      t.timestamps
    end
  end
end

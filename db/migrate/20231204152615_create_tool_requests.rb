class CreateToolRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :tool_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tool, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end

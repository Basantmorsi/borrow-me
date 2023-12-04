class CreateTools < ActiveRecord::Migration[7.1]
  def change
    create_table :tools do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.text :description
      t.boolean :availability, default: true
      t.text :manual
      t.string :brand

      t.timestamps
    end
  end
end

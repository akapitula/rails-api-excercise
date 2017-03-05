class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.date :starts_on
      t.date :ends_on
      t.integer :duration
      t.boolean :deleted, default: false
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end

class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.references :user
      t.string :name, null: false
      t.text :description
      t.string :event
      t.date :event_at

      t.timestamps
    end
  end
end

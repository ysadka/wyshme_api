class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user
      t.string     :name,        null: false
      t.date       :date
      t.text       :description

      t.timestamps
    end
  end
end

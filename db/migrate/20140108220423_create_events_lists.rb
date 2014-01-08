class CreateEventsLists < ActiveRecord::Migration
  def change
    create_join_table :events, :lists, table_name: :events_lists do |t|
      t.index :event_id
      t.index :list_id
    end
  end
end

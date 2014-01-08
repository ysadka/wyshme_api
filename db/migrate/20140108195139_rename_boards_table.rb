class RenameBoardsTable < ActiveRecord::Migration
  def change
    drop_table :boards_items
    
    rename_table :boards, :lists

    create_join_table :lists, :items, table_name: :items_lists do |t|
      t.index :item_id
      t.index :list_id
    end
  end
end

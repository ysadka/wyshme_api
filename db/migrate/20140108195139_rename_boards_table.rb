class RenameBoardsTable < ActiveRecord::Migration
  def up
    drop_join_table :boards, :items
    
    rename_table :boards, :lists

    create_join_table :lists, :items, table_name: :items_lists do |t|
      t.index :item_id
      t.index :list_id
    end
  end

  def down
    drop_join_table :lists, :items

    rename_table :lists, :boards

    create_join_table :boards, :items, table_name: :boards_items do |t|
      t.index :board_id
      t.index :item_id
    end
  end
end

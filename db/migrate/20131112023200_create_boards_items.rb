class CreateBoardsItems < ActiveRecord::Migration
  def change
    create_join_table :boards, :items, table_name: :boards_items do |t|
      t.index :board_id
      t.index :item_id
    end
  end
end

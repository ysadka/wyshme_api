class CreateCategoriesItems < ActiveRecord::Migration
  def change
    create_join_table :categories, :items, table_name: :categories_items do |t|
      t.index :category_id
      t.index :item_id
    end
  end
end

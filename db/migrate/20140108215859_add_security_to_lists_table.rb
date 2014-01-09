class AddSecurityToListsTable < ActiveRecord::Migration
  def up
    add_column :lists, :public,     :boolean
    add_column :lists, :active,     :boolean
    add_column :lists, :item_order, :string
  end

  def down
    remove_column :lists, :public
    remove_column :lists, :active
    remove_column :lists, :item_order
  end
end

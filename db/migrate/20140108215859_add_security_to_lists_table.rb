class AddSecurityToListsTable < ActiveRecord::Migration
  def change
    add_column :lists, :public,     :boolean
    add_column :lists, :active,     :boolean
    add_column :lists, :item_order, :string
  end
end

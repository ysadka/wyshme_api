class AddUrlAndRetailerToItems < ActiveRecord::Migration
  def change
    add_column :items, :url, :string
    add_column :items, :retailer, :string
  end
end

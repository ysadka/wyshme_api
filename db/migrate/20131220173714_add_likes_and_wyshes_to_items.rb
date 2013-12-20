class AddLikesAndWyshesToItems < ActiveRecord::Migration
  def up
    change_table :items do |t|
      t.integer :likes, default: 0
      t.integer :wyshes, default: 0
    end
    Item.update_all(likes: 0, wyshes: 0)
  end

  def down
    change_table :items do |t|
      t.remove :likes
      t.remove :wyshes
    end
  end
end

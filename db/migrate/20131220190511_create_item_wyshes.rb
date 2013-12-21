class CreateItemWyshes < ActiveRecord::Migration
  def change
    create_table :item_wyshes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :item, index: true
    end
  end
end

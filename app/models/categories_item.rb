class CategoriesItem < ActiveRecord::Base
  self.primary_key = [:category_id, :item_id]

  belongs_to :category
  belongs_to :item
end

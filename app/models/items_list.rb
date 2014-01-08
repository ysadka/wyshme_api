class ItemsList < ActiveRecord::Base
  self.primary_keys = :list_id, :item_id

  belongs_to :list
  belongs_to :item
end

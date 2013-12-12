class BoardsItem < ActiveRecord::Base
  self.primary_keys = :board_id, :item_id

  belongs_to :board
  belongs_to :item
end

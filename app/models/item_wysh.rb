class ItemWysh < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :item, dependent: :destroy

  validates :user_id, presence: true
  validates :item_id, presence: true

end

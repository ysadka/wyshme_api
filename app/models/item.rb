class Item < ActiveRecord::Base
  has_many :boards_items, dependent: :destroy
  has_many :boards, through: :boards_items
  has_many :categories_items, dependent: :destroy
  has_many :categories, through: :categories_items

  validates :name, presence: true
end

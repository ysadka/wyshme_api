class Board < ActiveRecord::Base
  belongs_to :user
  has_many :boards_items, dependent: :destroy
  has_many :items, through: :boards_items

  validates :user, :name, presence: true
end

class Item < ActiveRecord::Base
  has_many :boards_items, dependent: :destroy
  has_many :boards, through: :boards_items

  has_many :categories_items, dependent: :destroy
  has_many :categories, through: :categories_items

  has_many :item_likes
  has_many :item_wyshes

  has_attached_file :image, styles: { 
    medium: "300x300>",
    thumb: "100x100>"
    }, default_url: "/images/:style/missing.png"  

  validates :name, presence: true
  validates :image, attachment_presence: true
  validates_with AttachmentPresenceValidator, attributes: :image

end

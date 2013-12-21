class ItemLike < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :item, dependent: :destroy

  before_save :update_counter

  validates :user_id, presence: true
  validates :item_id, presence: true

  def update_counter
    if self.has_attribute? :count
      self.counter ||= 0
      self.counter += 1
    end
  end

end

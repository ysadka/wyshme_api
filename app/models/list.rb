class List < ActiveRecord::Base
  belongs_to :user
  has_many :items_lists, dependent: :destroy
  has_many :items, through: :items_lists

  has_many :events_lists
  has_many :events, through: :events_lists

  validates :user, :name, presence: true
end

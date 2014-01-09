class Event < ActiveRecord::Base

  belongs_to :user

  has_many :events_lists
  has_many :lists, through: :events_lists
end

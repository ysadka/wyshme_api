class EventsList < ActiveRecord::Base
  self.primary_keys = :event_id, :list_id

  belongs_to :event
  belongs_to :list
end

class EventSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :date, :description
        
  def is_deleted
    object.destroyed?
  end

  def errors
    object.errors.map { |f, m| { f => m } }
  end
end

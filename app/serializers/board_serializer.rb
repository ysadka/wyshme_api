class BoardSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :event, :event_at,
             :user_id, :is_deleted, :errors
  has_many :items, embed: :ids

  def user_id
    object.user_id
  end

  def is_deleted
    object.destroyed?
  end

  def errors
    object.errors.map { |f, m| { f => m } }
  end

end

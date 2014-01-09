class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :event, :event_at,
             :user_id, :is_deleted, :errors, :list_of_items
  has_many :items

  def user_id
    object.user_id
  end

  def is_deleted
    object.destroyed?
  end

  def errors
    object.errors.map { |f, m| { f => m } }
  end

  def list_of_items
    items = []
    object.item_order.split(',').each do |id|
      items << Item.find_by(id: id.to_i)
    end
  end
end

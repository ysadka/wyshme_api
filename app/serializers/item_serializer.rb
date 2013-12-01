class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :is_deleted, :errors
  has_many :categories

  def is_deleted
    object.destroyed?
  end

  def errors
    object.errors.map { |f, m| { f => m } }
  end

end

class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :is_deleted, :errors
  has_many :boards, embed: :ids
  has_many :categories, embed: :ids

  def is_deleted
    object.destroyed?
  end

  def errors
    object.errors.map { |f, m| { f => m } }
  end

end

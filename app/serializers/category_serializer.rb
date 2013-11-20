class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :is_deleted, :errors
  has_many :items, embed: :ids

  def is_deleted
    object.destroyed?
  end

  def errors
    object.errors.map { |f, m| { f => m } }
  end

end

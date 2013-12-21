class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :image_url,
             :likes, :wyshes, :url, :retailer, :is_deleted, :errors
  has_many :categories

  def is_deleted
    object.destroyed?
  end

  def errors
    object.errors.map { |f, m| { f => m } }
  end

  def image_url
    object.image.url
  end
end

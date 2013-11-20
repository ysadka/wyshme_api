class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :is_deleted, :errors
  has_many :boards, embed: :ids

  def is_deleted
    object.destroyed?
  end

  def errors
    object.errors.map { |f, m| { f => m } }
  end

end

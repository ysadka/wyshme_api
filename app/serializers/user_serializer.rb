class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name,
             :access_token, :is_deleted, :errors

  def is_deleted
    object.destroyed?
  end

  def errors
    object.errors.map { |f, m| { f => m } }
  end

end

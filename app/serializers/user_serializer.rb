class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :token, :name

  def token
    scope[:token]
  end
end

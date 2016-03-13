class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :user_type
end

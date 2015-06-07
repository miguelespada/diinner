class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :image_url
end
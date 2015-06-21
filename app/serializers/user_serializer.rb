class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :birth, :image_url, :gender
  has_one :preference
end

class RestaurantSerializer < ActiveModel::Serializer
  attributes :name, :description, :phone, :address, :contact_person, :latitude, :longitude, :photo
  belongs_to :city
end

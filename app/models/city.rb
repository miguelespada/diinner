class City
  include Mongoid::Document

  field :name, type: String
  field :latitude, type: String
  field :longitude, type: String
  has_many :restaurants
end
class City
  include Mongoid::Document

  field :name, type: String
  field :latitude, type: String
  field :longitude, type: String
  has_many :restaurants
  has_many :preferences

  def can_be_deleted?
    restaurants.count == 0 && preferences.count == 0
  end
end
module RestaurantSearchable
  extend ActiveSupport::Concern

  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name  "diinner-restaurant-#{Rails.env}"

    def as_indexed_json(options={})
      as_json(only: 'name').merge location: { lat: self.latitude.to_f, lon: self.longitude.to_f }
    end
    # TODO DO NOT ADD features WITHOUT test or spec!!!! [JODER GRRRR!!!!]
    mapping do
      indexes :name, type: :string, :analyzer => :spanish, :boost => 50
      indexes :location, type: 'geo_point'
    end

    def self.near(lat, lon, dist)
      search query: { 
                filtered: {
                  query: {
                    match_all: {}
                  },
                  filter: {
                    geo_distance: {
                      distance: "#{dist}km",
                      location: {
                        lat: lat,
                        lon: lon
                      }
                    }
                  }
                }
            }
    end
  end
end

module RestaurantSearchable
  extend ActiveSupport::Concern

  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name  "diinner-restaurant-#{Rails.env}"

    def as_indexed_json(options={})
      as_json(only: 'name').merge location: { lat: self.latitude.to_f, lon: self.longitude.to_f }
    end
    # TODO DO NOT ADD features WITHOUT test or spec!!!! [JODER]
    mapping do
      indexes :name, type: :string, :analyzer => :spanish, :boost => 50
      indexes :email, type: :string, :boost => 50
      indexes :description, type: :string, :analyzer => :spanish, :boost => 40
      indexes :phone, type: :string, :boost => 50
      indexes :address, type: :string, :analyzer => :spanish, :boost => 50
      indexes :city, type: :string, :analyzer => :spanish, :boost => 20
      indexes :location, type: 'geo_point'
    end

    def near lat, lon, dist

    end

  end
end
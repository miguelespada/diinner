module RestaurantSearchable
  extend ActiveSupport::Concern

  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name  "restaurants-#{Rails.env}"
    
    def location
      "#{latitude},#{longitude}"
    end

    def as_indexed_json(options={})
        {
        name: name, 
        lat_lon: location
      }.to_json
    end

    mappings do
      indexes :name, type: :string, :analyzer => :spanish, :boost => 50
      indexes :lat_lon, type: 'geo_point'
    end

    def self.near(lat, lon, distance)

      location = [lat, lon].join(',')
      distance = "#{distance}km"
      
      query = Jbuilder.encode do |json|
          json.query do
            json.filtered do
              json.query do
                json.match do
                  json._all do
                    json.query "*"
                  end
                end
              end
              # json.filter do
              #   json.range do
              #     json.created_at { json.from '2013-04-01'  }
              #   end
              # end
              json.filter do
                json.geo_distance do
                  json.distance distance
                  json.pin.location do
                    json.lat 20
                    json.lon 20
                  end
                end
              end
            end
          end
        end
      p query
      
      self.search(query).results.total
    end

  end
end

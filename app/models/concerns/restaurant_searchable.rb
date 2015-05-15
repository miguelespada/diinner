module RestaurantSearchable
  extend ActiveSupport::Concern

  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name  "diinner-restaurant-#{Rails.env}"

    def as_indexed_json(options={})
      as_json(only: [:name, :email, :description, :phone, :address, :city])
    end

    mapping do
      indexes :name, type: :string, :analyzer => :spanish, :boost => 50
      indexes :email, type: :string, :analyzer => :spanish, :boost => 50
      indexes :description, type: :string, :analyzer => :spanish, :boost => 40
      indexes :phone, type: :string, :analyzer => :spanish, :boost => 50
      indexes :address, type: :string, :analyzer => :spanish, :boost => 50
      indexes :city, type: :string, :analyzer => :spanish, :boost => 20
    end

  end
end

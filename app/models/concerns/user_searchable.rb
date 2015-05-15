module UserSearchable
  extend ActiveSupport::Concern

  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name  "diinner-user-#{Rails.env}"

    def as_indexed_json(options={})
      as_json(only: [:name, :email, :image_url, :birth, :gender])
    end

    mapping do
      indexes :name, type: :string, :analyzer => :spanish, :boost => 50
      indexes :email, type: :string, :boost => 50
      indexes :image_url, type: :string, :boost => 40
      indexes :birth, type: :date, :boost => 50
      indexes :gender, type: :string, :boost => 50
    end
  end
end

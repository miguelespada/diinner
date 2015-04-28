module UserSearchable
  extend ActiveSupport::Concern

  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name  "users-#{Rails.env}"

    def as_indexed_json(options={})
      as_json(only: 'name')
    end

    mapping do
      indexes :name, type: :string, :analyzer => :spanish, :boost => 50
    end
  end
end

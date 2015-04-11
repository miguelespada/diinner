module Searchable
  extend ActiveSupport::Concern

  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name  "restaurants-#{Rails.env}"

    def as_indexed_json(options={})
      as_json(only: 'name')
    end

    mapping do
      indexes :name, type: :string, :analyzer => :snowball, :boost => 50
    end

    def self.search(query)
      self.__elasticsearch__.search query
    end
  end
end

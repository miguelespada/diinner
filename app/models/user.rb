class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # TODO: Do not copy&paste, use BDD (first test then feature)
  # include Searchable

  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""
end
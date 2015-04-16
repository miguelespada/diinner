class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Searchable

  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""
end
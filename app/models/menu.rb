class Menu
  include Mongoid::Document
  field :name,  type: String, default: ""
  field :price, type: String, default: ""

  belongs_to :restaurant
end

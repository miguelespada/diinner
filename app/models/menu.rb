# TODO First test then feature!!!!
class Menu
  include Mongoid::Document
  field :name,  type: String, default: ""
  # TODO This a integer
  field :price, type: String, default: ""

  belongs_to :restaurant
  belongs_to :table
end

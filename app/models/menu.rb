class Menu
  include Mongoid::Document
  field :name,  type: String, default: ""
  field :price, type: Integer
  field :appetizer, type: String, default: ""
  field :main_dish, type: String, default: ""
  field :dessert, type: String, default: ""
  field :drink, type: String, default: ""

  belongs_to :restaurant
  belongs_to :table

  def is_owned_by?(restaurant)
    restaurant == self.restaurant
  rescue
    false
  end
end

class Menu
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,  type: String, default: ""
  field :price, type: Integer
  field :appetizer, type: String, default: ""
  field :main_dish, type: String, default: ""
  field :dessert, type: String, default: ""
  field :drink, type: String, default: ""

  belongs_to :restaurant

  def user_count
    restaurant.tables.select{|table| table.menu == self}
                      .map{|table| table.user_count}
                      .inject(:+) || 0
  end

  def empty?
    user_count == 0
  end

  def is_owned_by?(restaurant)
    restaurant == self.restaurant
  rescue
    false
  end
end

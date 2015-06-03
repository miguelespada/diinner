class Menu
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common

  field :name,  type: String, default: ""
  field :price, type: Integer
  field :description, type: String
  field :appetizer, type: String, default: ""
  field :main_dish, type: String, default: ""
  field :dessert, type: String, default: ""
  field :drink, type: String, default: ""

  belongs_to :restaurant

  validates :description, presence: true

  def user_count
    restaurant.tables.select{|table| table.menu == self}
                      .map{|table| table.user_count}
                      .inject(:+) || 0
  end

  def exists_in_database?
    created_at != nil
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

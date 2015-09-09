class Menu
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common
  after_destroy :remove_activities

  field :name,  type: String
  field :price, type: Integer
  field :description, type: String
  field :appetizer, type: String, default: ""
  field :main_dish, type: String, default: ""
  field :dessert, type: String, default: ""
  field :drink, type: String, default: ""

  belongs_to :restaurant

  validates :name, presence: true

  def user_count
    restaurant.tables.select{|table| table.menu == self}
                      .map{|table| table.user_count}
                      .inject(:+) || 0
  end

  def empty?
    user_count == 0
  end

  def is_owned_by? user
    return true if restaurant == user
  rescue
    false
  end

  def to_ionic_json
    {
        name: self.name,
        description: self.description,
        price: self.price,
        appetizer: self.appetizer,
        main_dish: self.main_dish,
        dessert: self.dessert,
        drink: self.drink
    }
  end
end
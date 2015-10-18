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
  has_many :tables

  validates_presence_of :name

  def user_count
    tables.map{|table| table.user_count}.inject(:+) || 0
  end

  def empty?
    user_count == 0
  end
  
  def can_be_deleted?
    tables.count == 0
  end


  def is_owned_by? user
    return true if restaurant == user
  rescue
    false
  end

  def to_ionic_json
    {
        name: name,
        description: description,
        price: price,
        appetizer: appetizer,
        main_dish: main_dish,
        dessert: dessert,
        drink: drink
    }
  end
end
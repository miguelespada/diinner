class Table
  include Mongoid::Document
  include Mongoid::Timestamps
  include Loggeable

  field :date, type: DateTime

  belongs_to :restaurant
  has_many :reservations
  delegate :menus, :to => :restaurant

  def hour
    # TODO define hour as a field
    "21:00"
  end

  def price
    empty? ? :undefined : reservations.first.price
  end

  def menu
    empty? ? :undefined : menus.select{|menu| menu.price == self.price}.first
  end

  def is_owned_by?(restaurant)
    restaurant == self.restaurant
  rescue
    false
  end

  def user_count
    reservations.map{|r| r.user_count}.inject(:+) || 0
  end

  def full?
    user_count == 6
  end

  def empty?
    user_count == 0
  end

  def partial?
    !full? && !empty?
  end

  def slots_left
    6 - user_count
  end

  def status
    return :full if full?
    return :empty if empty?
    return :partial
  end

  def is_on_day? day
    date.to_date == day
  end

  def matches_menu_price? target_price
    menus.select{|menu| menu.price == target_price} != []
  end

  def matches? day, target_price, customer_count
    is_on_day?(day) &&
    matches_menu_price?(target_price) &&
    slots_left >= customer_count
  end
end
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

  def male_count
    reservations.map{|r| r.male_count}.inject(:+) || 0
  end

  def female_count
    reservations.map{|r| r.female_count}.inject(:+) || 0
  end

  def male_slots_left
    3 - male_count
  end

  def female_slots_left
    3 - female_count
  end

  def has_free_slots? genders
    male_slots_left >= genders[:male] &&
    female_slots_left >= genders[:female]
  end

  def matches? reservation
    is_on_day?(reservation.date) &&
    matches_menu_price?(reservation.price) &&
    has_free_slots?(reservation.genders)
  end
end
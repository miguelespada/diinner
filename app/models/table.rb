class Table
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common
  extend SimpleCalendar

  has_calendar :attribute => :date

  field :date, type: Date
  field :hour, type: Time

  belongs_to :restaurant
  has_many :reservations
  delegate :menus, :to => :restaurant
  delegate :city, :to => :restaurant

  def price
    empty? ? :undefined : reservations.first.price
  end

  def menu
    empty? ? :undefined : menus.select{|menu| menu.price == self.price}.first
  end

  def user_count
    male_count + female_count
  end

  def full?
    user_count == 6
  end

  def plan_closed?
   female_count >= 2 && male_count >= 2
  end

  def partial?
    !plan_closed?
  end

  def empty?
    user_count == 0
  end

  def male_slots_left
    3 - male_count
  end

  def female_slots_left
    3 - female_count
  end

  def is_owned_by?(restaurant)
    restaurant == self.restaurant
  rescue
    false
  end

  def status
    return :full if full?
    return :plan_closed if plan_closed?
    return :empty if empty?
    return :partial
  end

  def matches_menu_price? target_price
    menus.select{|menu| menu.price == target_price} != []
  end

  def has_free_slots? genders
    male_slots_left >= genders[:male] &&
    female_slots_left >= genders[:female]
  end

  def matches? reservation
    matches_menu_price?(reservation.price) &&
    has_free_slots?(reservation.genders)
  end

  def capture
    reservations.map{|r| r.capture}
  end

  def charge
    reservations.map{|r| r.charge}
  end

  def refund
    reservations.map{|r| r.refund}
  end

  def paid_reservations
    reservations.select{|r| r.paid?}
  end

  def paid_male_count
    self.count :male, paid_reservations
  end

  def paid_female_count
    self.count :female, paid_reservations
  end

  def male_count
    self.count :male, reservations
  end

  def female_count
    self.count :female, reservations
  end

  def count gender, _reservations
    _reservations.map{|r| r.send "#{gender}_count"}.inject(:+) || 0
  end
end
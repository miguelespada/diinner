class Table
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common
  extend SimpleCalendar

  has_calendar :attribute => :date

  field :date, type: Date
  field :hour, type: Time
  field :cancelled, type: Boolean, default: false

  belongs_to :restaurant
  has_many :reservations
  delegate :menus, :to => :restaurant
  delegate :city, :to => :restaurant

  attr_accessor :number


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

  def status
    return :cancelled if cancelled?
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

  def male_count
    self.count :male, reservations
  end

  def female_count
    self.count :female, reservations
  end

  def count gender, _reservations
    _reservations.map{|r| r.send "#{gender}_count"}.inject(:+) || 0
  end

  def cancel
    self.update(cancelled: true)
    reservations.map{|r| r.cancel}
    self.save!
  end

  def notify action
    self.create_activity key: "table.#{action}", owner: restaurant
  end

  def notify_cancellation
    self.create_activity key: 'table.cancel', recipient: restaurant
    reservations.map{|r| r.notify_plan("cancel")}
  end

  def notify_plan
    self.create_activity key: 'table.confirmed', recipient: restaurant
    reservations.map{|r| r.notify_plan("confirmed") if r.paid?}
    reservations.map{|r| r.notify_plan("cancel") if r.cancelled?}
  end

  def is_owned_by? user
    return true if restaurant == user
  rescue
    false
  end


end
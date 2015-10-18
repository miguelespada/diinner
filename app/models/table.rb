class Table
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common
  extend SimpleCalendar
  after_destroy :remove_activities

  has_calendar :attribute => :date

  field :date, type: Date
  field :hour, type: Time
  field :cancelled, type: Boolean, default: false
  field :processed, type: Boolean, default: false
  
  belongs_to :restaurant
  has_many :reservations
  belongs_to :menu

  delegate :price, :to => :menu
  delegate :city, :to => :restaurant

  attr_accessor :number, :repeat_until

  def affinity
    # TODO memoize
    return 100 if reservations.count == 0
    aff = 0
    i = 0
    while i < reservations.count - 1 do
      j = i + 1
      while j <  reservations.count do
        aff += reservations[i].affinity(reservations[j])
        j += 1
      end
      i += 1
    end
    aff /= reservations.count.to_f
    (70 + aff * 30).to_i
  end

  def can_be_deleted?
    self.empty?
  end
  
  def passed?
    date < Date.today  
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

  def matches_menu_price? range
    return menu.price.between?(10, 35) if range == :lowcost
    return menu.price.between?(35, 50) if range == :regular
    return menu.price.between?(50, 90) if range == :premium
  end

  def has_free_slots? genders
    return false if cancelled?
    male_slots_left >= genders[:male] &&
    female_slots_left >= genders[:female]
  end

  def matches_age? user
    reservations.each do |r|
      return false if !user.matches_age_preference? (r.user)
      return false if !r.user.matches_age_preference? (user)
    end
    true
  end

  def matches? reservation
    matches_menu_price?(reservation.menu_range) &&
    has_free_slots?(reservation.genders) &&
    matches_age?(reservation.user)
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


  def must_cancel_last_minute? 
    must_cancel = false
    reservations.each do |r|
      return true if r.is_last_minute? && r.cancelled?
    end
    must_cancel
  end

  def refund_last_minute
    reservations.map{|r| r.refund if r.is_last_minute?}
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


  def notify_cancellation
    NotificationManager.notify_cancel_table(object: self, to: restaurant)
    reservations.map{|r| r.notify_cancellation }
  end

  def notify_confirmation
    NotificationManager.notify_comfirm_table(object: self, to: restaurant)
    # Note that the plan is confirmed but some of the reservation may not
    reservations.map{|r| r.paid? ? r.notify_confirmation : r.notify_cancellation }
  end


  def notify_cancel_last_minute
    reservations.map{|r| r.notify_cancellation if r.cancelled?}
  end

  def cancel_last_minute
    reservations.map{|r| r.cancel if r.pending? }
  end

  def locator
    # TODO DRY this
    # TODO store key in env
    i = (id.to_s[5..7] + id.to_s[18..20]).to_i(30)
    "T_" + Hashids.new("The salt of every").encode(i)
  end

  def is_owned_by? user
    return true if restaurant == user
  rescue
    false
  end


end
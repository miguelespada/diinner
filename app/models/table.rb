class Table
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common
  extend SimpleCalendar
  after_destroy :remove_activities
  before_save :generate_locator


  field :date, type: Date
  field :hour, type: Time
  field :cancelled, type: Boolean, default: false
  field :processed, type: Boolean, default: false
  field :locator, type: String
  
  belongs_to :restaurant
  has_many :reservations
  belongs_to :menu

  delegate :price, :to => :menu
  delegate :city, :to => :restaurant


  attr_accessor :number, :repeat_until

  def start_time
    date
  end

  def is_today?
    date.today?
  end

  def uncancelled_reservations
    reservations.includes(:user).reject{|r| r.cancelled?}
  end

  def purge_cancelled_reservations
    self.reservations.each{|r| r.destroy if r.cancelled?}
    self.reservations = uncancelled_reservations
    self.save!
  end

  def affinity
    Rails.cache.fetch([self.class.name, self.id, "affinity"], expires_in: 1.hour) do
      res = uncancelled_reservations.to_a
      return 100 if res.count <= 1
      aff = 0
      i = 0
      while i < res.count - 1 do
        j = i + 1
        while j <  res.count do
          aff += res[i].affinity(res[j])
          j += 1
        end
        i += 1
      end
      aff /= res.count.to_f
      (70 + aff * 30).to_i
    end
  rescue
    75
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
    return menu.price.between?(PRICES_RANGES["lowcost"]["min"],  PRICES_RANGES["lowcost"]["max"]) if range == :lowcost
    return menu.price.between?(PRICES_RANGES["regular"]["min"],  PRICES_RANGES["regular"]["max"]) if range == :regular
    return menu.price.between?(PRICES_RANGES["premium"]["min"],  PRICES_RANGES["premium"]["max"]) if range == :premium
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
    self.cancelled = true
    reservations.map{|r| r.cancel}
    self.save!
  end

  def notify_cancellation
    NotificationManager.notify_cancel_table(object: self, to: restaurant)
    reservations.map{|r| r.notify_cancellation }
  end

  def notify_confirmation
    NotificationManager.notify_comfirm_table(object: self, to: restaurant)
    EmailNotifications.notify_table_confirmation self
    # Note that the plan is confirmed but some of the reservation may not
    reservations.map{|r| r.paid? ? r.notify_confirmation : r.notify_cancellation }
  end

  def cancel_one gender
    reservations.desc(:created_at).each do |r|
      if r.genders[gender] == 1
        r.cancel
        r.notify_cancellation
        return
      end
    end
  end

  def notify_cancel_last_minute
    reservations.map{|r| r.notify_cancellation if r.cancelled?}
  end

  def cancel_last_minute
    reservations.map{|r| r.cancel if r.pending? }
  end
  
  def has_last_minutes?
    reservations.each do |r|
      return true if r.is_last_minute?
    end
    return false
  end

  def generate_locator
    i = (id.to_s[5..7] + id.to_s[18..20]).to_i(30)
    self.locator = "T_" + Hashids.new("The salt of every").encode(i)
  end

  def is_owned_by? user
    return true if restaurant == user
  rescue
    false
  end


  

end
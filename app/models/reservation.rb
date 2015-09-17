class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common
  include ReservationPayment
  include ReservationStatus
  extend SimpleCalendar
  after_destroy :remove_activities

  has_calendar :attribute => :date

  belongs_to :user
  belongs_to :table

  field :price, type: Integer
  field :date, type: Date
  field :after_plan, type: Boolean

  delegate  :restaurant,
            :hour,
            :menu, :to => :table, :allow_nil => true

  delegate :customer, :to => :user
  delegate :city, :to => :restaurant, :allow_nil => true


  embeds_many :companies

  accepts_nested_attributes_for :companies,
           :reject_if => :all_blank,
           :allow_destroy => true

  has_one :payment, :dependent => :destroy
  has_one :evaluation, :dependent => :destroy

  def go_for_drinks?
    after_plan
  end

  def go_to_sleep?
    !go_for_drinks
  end
  
  def plan_affinity other
    self.after_plan == other.after_plan ? 1.0 : 0.0 
  end 

  def affinity other
    (self.user.affinity(other.user) + plan_affinity(other) ) / 2.0
  end

  def male_count
    cancelled? ? 0 : genders[:male]
  end

  def female_count
    cancelled? ? 0 : genders[:female]
  end

  def genders
    results = {:male => 0, :female => 0}
    results[user.gender] += 1
    companies.each do |c|
      results[c.gender] += 1
    end
    results
  end

  def is_owned_by?(user)
    user == self.user || self.table.restaurant == user
  rescue
    false
  end

  def date_and_time
    DateTime.new(self.date.year, self.date.month, self.date.day, self.hour.hour, self.hour.min, self.hour.sec, self.hour.zone)
  end

  def locator
    i = (id.to_s[5..7] + id.to_s[18..20]).to_i(30)
    "R_" + Hashids.new("The salt of every").encode(i)
  end

  def cancel
    self.update(cancelled: true)
  end

  def notify_cancellation
    NotificationManager.notify_cancel_plan(object: self, to: user)
  end

  def notify_confirmation
    NotificationManager.notify_confirm_plan(object: self, to: user)
  end

  def has_evaluation?
    !evaluation.nil?
  end

  def is_last_minute?
    today = Date.today
    date.day == today.day && date.month == today.month && date.year == today.year
  end

  def self.off_the_clock?
    nine = DateTime.now.change({ hour: 9, min: 00, sec: 00 })
    six = DateTime.now.change({ hour: 18, min: 00, sec: 00 })
    now = DateTime.now
    now < nine || now > six 
  end

  def self.invite_to_evaluate
    n = 0
    Reservation.each do |r|
      if r.can_be_evaluated?
        r.invite_to_evaluate
        n += 1
      end
    end
    n 
  end

  def invite_to_evaluate
    NotificationManager.notify_invitation_to_evaluate(object: self, to: user)
  end

  def to_ionic_json
    {
      id: self.id.to_s,
      cancelled: self.cancelled?,
      date: self.date_and_time,
      time: self.hour,
      price: self.price,
      affinity: self.table.affinity,
      restaurant: self.restaurant.to_ionic_json,
      menu: self.menu.to_ionic_json,
      table_id: self.table.id.to_s,
      companies: self.companies.map{ |company| {
          reservation: company.to_ionic_json
        }
      }
    }
  end

end
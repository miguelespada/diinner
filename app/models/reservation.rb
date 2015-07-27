class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common
  include ReservationPayment
  include ReservationStatus
  extend SimpleCalendar
  has_calendar :attribute => :date

  belongs_to :user
  belongs_to :table

  field :price, type: Integer
  field :date, type: Date

  delegate  :restaurant,
            :hour,
            :menu, :to => :table, :allow_nil => true

  delegate :customer, :to => :user
  delegate :city, :to => :restaurant, :allow_nil => true

  embeds_many :companies

  accepts_nested_attributes_for :companies,
           :reject_if => :all_blank,
           :allow_destroy => true

  has_one :payment
  has_one :evaluation

  def affinity
    # TODO Calculate affinity
    "80%"
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
    id.to_s.hex.to_s 32
  end

  def cancel
    self.update(cancelled: true)
  end

  def notify_plan action
    self.create_activity key: "plan.#{action}", recipient: user
  end

  def notify action
    self.create_activity key: "reservation.#{action}", owner: user, recipient: restaurant
  end

  def has_evaluation?
    !evaluation.nil?
  end

  def to_ionic_json
    {
      id: self.id.to_s,
      cancelled: self.cancelled?,
      date: self.date_and_time,
      time: self.hour,
      price: self.price,
      affinity: self.affinity,
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
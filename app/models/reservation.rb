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

  field :paid, type: Boolean, default: false
  field :charge_id, type: String
  field :ticket_valid, type: Boolean, default: false
  field :payment_error, type: Boolean, default: false

  def affinity
    # TODO Calculate affinity
    # Maybe delegate to the table
    "80%"
  end

  def male_count
    genders[:male]
  end

  def female_count
    genders[:female]
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

  def locator
    id.to_s.to_i.to_s 32
  end
end
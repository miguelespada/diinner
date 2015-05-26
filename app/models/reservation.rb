class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :table

  field :price, type: Integer
  field :customer, type: String
  field :paid, type: Boolean, default: false
  field :date, type: Date

  delegate  :restaurant,
            :hour,
            :menu, :to => :table, :allow_nil => true

  embeds_many :companies

  accepts_nested_attributes_for :companies,
           :reject_if => :all_blank,
           :allow_destroy => true

  def male_count
    genders[:male]
  end

  def female_count
    genders[:female]
  end

  def user_count
    companies.all.count + 1
  end

  def confirmed?
    !paid? && customer.present?
  end

  def status
    # TODO cancelled
    # TODO with error
    return :paid if paid?
    return :confirmed if confirmed?
    return :pending
  end

  def affinity
    # TODO Calculate affinity
    # Maybe delegate to the table
    "80%"
  end

  def self.process
    all.each do |reservation|
      reservation.charge if reservation.confirmed?
    end
  end

  def charge
    begin
      Stripe::Charge.create(
        :amount   => price * user_count * 100,
        :currency => "eur",
        :customer => customer
      )

      self.update(paid: true)
    rescue Stripe::CardError => e
      # TODO The card has been declined
    end
  end

  def update_customer_information! token
    customer = Stripe::Customer.create(
      :source => token,
      :description => user.name
    )
    update!(customer: customer.id)
  end

  def is_owned_by?(user)
    user == self.user || self.table.restaurant == user
  rescue
    false
  end

  def genders
    results = {:male => 0, :female => 0}
    results[user.gender] += 1
    companies.each do |c|
      results[c.gender] += 1
    end
    results
  end
end
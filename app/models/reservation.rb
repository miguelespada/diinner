class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :table

  field :price, type: Integer
  field :customer, type: String
  field :paid, type: Boolean, default: false
  attr_accessor :date

  # TODO add number of user (in case of invitations)
  # field :plus_one, :type Boolean

  def user_count
    1
  end

  def confirmed?
    !paid? && customer.present? 
  end

  def status
    # TODO cancelled
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
        :amount   => price * 100, 
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

  def assigned_menu
    table.assigned_menu
  rescue
    :undefined
  end

  def hour
    table.hour
  rescue
    :undefined
  end

  def date
    table.date
  rescue
    :undefined
  end

  delegate :restaurant, :hour, :assigned_menu, :to => :table

  def date
    table.date if !table.nil?
  end
end
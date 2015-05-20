class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :table

  field :price, type: Integer
  field :customer, type: Integer
  attr_accessor :date


  # TODO add number of user (in case of invitations)
  # field :plus_one, :type Boolean
  
  def user_count
    1
  end

  def status
    # TODO confirmed/paid/cancelled
    return :confirmed if customer.present?
    return :pending
  end

  def affinity
    # TODO Calculate affinity
    # Maybe delegate to the table
    "80%"
  end

  def update_customer_information! token
    customer = Stripe::Customer.create(
      :source => token,
      :description => user.name
    )
    self.update(customer: customer.id)
  end

  def is_owned_by?(user)
    user == self.user
  rescue
    false
  end
end
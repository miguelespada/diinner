class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :table

  field :price, type: Integer
  field :stripe_card_token, type: String
  attr_accessor :date


  # TODO add number of user (in case of invitations)
  # field :plus_one, :type Boolean
  
  def user_count
    1
  end

  def status
    # TODO confirmed/paid/cancelled
    return :confirmed if stripe_card_token.present?
    return :pending
  end

  def affinity
    # TODO Calculate affinity
    # Maybe delegate to the table
    "80%"
  end

  def is_owned_by?(user)
    user == self.user
  rescue
    false
  end
end
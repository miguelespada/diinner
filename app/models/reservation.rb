class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum
  belongs_to :user
  belongs_to :table

  field :price, type: Integer
  field :date, type: DateTime

  # TODO add invited
  # TODO add payment token

  # STATUS
  # Pending, payment details not set
  # Confirmed, payment details set, but not paid
  # Paid 
  # Cancelled,

  enum :status, [:pending, :confirmed, :paid, :cancelled], default: :pending
  

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
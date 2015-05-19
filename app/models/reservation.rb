class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum
  belongs_to :user
  belongs_to :table

  field :price, type: Integer
  field :date, type: DateTime

  enum :status, [:pending, :confirmed, :paid, :cancelled], default: :pending
 
  def is_owned_by?(user)
    user == self.user
  rescue
    false
  end
end
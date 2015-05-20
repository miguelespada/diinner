class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :table

  field :price, type: Integer

  # TODO add number of user (in case of invitations)

  attr_accessor :date

  def status
    :confirmed
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
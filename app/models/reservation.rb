class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  belongs_to :table

  field :price, type: Integer
  field :date, type: DateTime
 
  def is_owned_by?(user)
    user == self.user
  rescue
    false
  end
end
class Reservation
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user

  field :price, type: Integer
  field :date, type: DateTime
end
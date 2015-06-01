class Payment
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :reservation
  belongs_to :restaurant
  field :stripe_data, type: Hash
end
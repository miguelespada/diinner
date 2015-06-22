class Evaluation
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :reservation
  delegate :restaurant, :to => :reservation
  field :comments, type: String
end
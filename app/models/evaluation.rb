class Evaluation
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :reservation

  delegate :restaurant, :to => :reservation
  
  field :comments, type: String
  field :quality_of_menu, type: Integer
  field :quality_of_restaurant, type: Integer
  field :had_fun, type: Boolean
  field :would_recommend, type: Boolean
end
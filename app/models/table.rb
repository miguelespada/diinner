class Table
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum
  include Loggeable

  # TODO do we need the name?
  field :name, type: String, default: ""
  
  # TODO  this should be a method inferred from the numbers of user
  enum :status, [:full, :empty, :partial]

  field :slots, type: Integer, default: 6
  field :date, type: DateTime

  # TODO maybe this should be a method inferred by the first user
  enum :sexual_condition, [:hetero, :lesbian, :gay] 

  belongs_to :restaurant
  has_many :users
  has_one :menu

  def is_owned_by?(restaurant) 
    # TODO refactor in a straight way self.restaurant == restaurant
    restaurant.tables.include?(self)
  rescue
    false
  end
end

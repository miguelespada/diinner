class Table
  include Mongoid::Document
  include Mongoid::Timestamps
  include Loggeable

  # TODO do we need to record the slots? This a global constant
  # field :slots, type: Integer, default: 6
  field :date, type: DateTime

  # TODO maybe this should be a method inferred by the first user
  # enum :sexual_condition, [:hetero, :lesbian, :gay]

  belongs_to :restaurant
  has_many :users
  has_one :menu

  def is_owned_by?(restaurant)
    restaurant == self.restaurant
  rescue
    false
  end

  # This is more readable 
  # Move '6' to a config variable
  def is_full?
    users.count == 6
  end

  def is_empty?
    users.count == 0
  end

  def is_partial?
    !is_full? && !is_empty?
  end

  def slots_left
    6 - users.count
  end

  def status
    # For simple conditions it is recommended to use compact syntax
    # The older version agaings Single Responsability Principle
    return :full if is_full?
    return :empty if is_empty?
    return :partial 
  end

  # TODO do we need the name?
  # def name
  #   id
  # end

end

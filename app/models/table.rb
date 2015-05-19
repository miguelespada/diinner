class Table
  include Mongoid::Document
  include Mongoid::Timestamps
  include Loggeable

  field :date, type: DateTime

  # TODO maybe this should be a method inferred by the first user
  # enum :sexual_condition, [:hetero, :lesbian, :gay]

  belongs_to :restaurant
  has_many :users
  has_one :menu

  def hour
    # TODO define hour as a field
    "21:00"
  end

  def menu 
    # TODO define menus as a list 
    restaurant.menus.first
  end

  def is_owned_by?(restaurant)
    restaurant == self.restaurant
  rescue
    false
  end

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
    return :full if is_full?
    return :empty if is_empty?
    return :partial 
  end

end
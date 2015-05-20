class Table
  include Mongoid::Document
  include Mongoid::Timestamps
  include Loggeable

  field :date, type: DateTime

  belongs_to :restaurant
  has_many :reservations

  def hour
    # TODO define hour as a field
    "21:00"
  end

  def menu 
    # TODO define menus as a list
    # A table can have different menus
    restaurant.menus.first
  end

  def sexual_condition
    # TODO inferred from user
    :undefined
  end

  def is_owned_by?(restaurant)
    restaurant == self.restaurant
  rescue
    false
  end

  def user_count
    reservations.map{|r| r.user_count}.inject(:+) || 0
  end

  def is_full?
    user_count == 6
  end

  def is_empty?
    user_count == 0
  end

  def is_partial?
    !is_full? && !is_empty?
  end

  def slots_left
    6 - user_count
  end

  def status
    return :full if is_full?
    return :empty if is_empty?
    return :partial 
  end

end
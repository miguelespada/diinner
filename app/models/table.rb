class Table
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum
  include Loggeable

  field :slots, type: Integer, default: 6
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

  def is_full?
    self.status == :full
  end

  def is_empty?
    self.status == :empty
  end

  def is_partial?
    self.status == :partial
  end

  def slots_occupied
    users.count
  end

  def slots_left
    slots - users.count
  end

  def status
    if slots_occupied == self.slots
      return :full
    elsif slots_occupied == 0
      return :empty
    end
    :partial
  end

  def name
    id
  end

end

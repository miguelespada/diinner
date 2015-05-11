class Table
  include Mongoid::Document
  include Mongoid::Enum

  field :name, type: String, default: ""
  enum :status, [:full, :empty, :partial]
  field :slots, type: Integer, default: 6
  field :date, type: DateTime
  enum :sexual_condition, [:hetero, :lesbian, :gay]

  belongs_to :restaurant
  has_many :users
  has_one :menu

  def is_owned_by?(user)
    user.tables.include?(self)
  rescue
    false
  end
end

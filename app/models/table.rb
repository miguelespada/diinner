class Table
  include Mongoid::Document
  include Mongoid::Enum

  enum :status, [:full, :empty, :partial]
  field :slots, type: Integer, default: 6
  field :date, type: DateTime
  enum :sexual_condition, [:hetero, :lesbian, :gay]

  belongs_to :restaurant
  has_many :users
  has_one :menu
end

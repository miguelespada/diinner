class Preference
  include Mongoid::Document
  field :max_age, type: Integer
  field :min_age, type: Integer
  field :menu_price, type: Integer
  belongs_to :city
  belongs_to :user
end
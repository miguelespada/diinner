class Preference
  include Mongoid::Document
  field :max_age, type: Integer
  field :min_age, type: Integer
  field :menu_price, type: Integer
  field :after_plan, type: Boolean
  belongs_to :city
  belongs_to :user

  def to_ionic_json
    {
        min_age: self.min_age,
        max_age: self.max_age,
        city_id: self.city ? self.city.id.to_s : nil,
        menu_price: self.menu_price
    }
  end
end
class Preference
  include Mongoid::Document
  field :max_age, type: Integer
  field :min_age, type: Integer
  field :menu_price, type: Integer
  field :after_plan, type: Boolean
  belongs_to :city
  belongs_to :user
  before_save :set_defaults

  def check_age_range

    if self.min_age.nil?
      self.min_age = user.age - 10
      self.min_age = 18 if self.min_age < 18
    end

    if self.max_age.nil?
      self.max_age = user.age + 10
    end

    if self.min_age > self.max_age
      self.min_age, self.max_age = self.max_age, self.min_age
    end
  end

  def set_defaults
    check_age_range
  end

  def to_ionic_json
    {
        min_age: self.min_age,
        max_age: self.max_age,
        city_id: self.city ? self.city.id.to_s : nil,
        menu_price: self.menu_price
    }
  end
end
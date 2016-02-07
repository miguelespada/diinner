class Preference
  include Mongoid::Document
  include Mongoid::Enum

  field :max_age, type: Integer
  field :min_age, type: Integer

  enum :menu_range, [:lowcost, :regular, :premium]
  field :after_plan, type: Boolean
  field :use_photo_for_compatibility, type: Boolean
  belongs_to :city
  belongs_to :user
  before_save :set_defaults

  def set_defaults

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

  def has_city?
    !city.nil?
  end

  def to_ionic_json
    {
        min_age: min_age,
        max_age: max_age,
        city_id: has_city? ? city.id.to_s : nil,
        menu_range: menu_range
    }
  end
end
class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum

  field :age, type: Integer
  enum :gender, [:male, :female]

  embedded_in :reservation

  def to_ionic_json
    {
        id: self.id,
        gender: self.gender,
        age: self.age
    }

  end
end
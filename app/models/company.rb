class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum

  field :age, type: Integer
  enum :gender, [:male, :female]

  embedded_in :reservation

  def to_ionic_json
    {
        id: id,
        gender: gender,
        age: age
    }
  end
end
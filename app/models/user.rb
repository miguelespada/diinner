class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include UserSearchable
  include Loggeable
  include Notificable
  include Mongoid::Enum

  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""
  field :birth, type: Date
  enum :gender, [:male, :female, :undefined]

  # TODO: no sería has_many?
  has_one :test_response
  belongs_to :table

  def first_login?
    updated_at == created_at
  end

  def opposite_sex
    if gender == :male
      :female
    elsif gender == :female
      :male
    else
      :none
    end
  end

  def get_test_response_ids
    # TODO WTF!!!
    # Use associations
    # TODO esto no tiene sentido
    ids = []
    TestResponse.where(user: self).each do |response|
      ids.push(response.test.id)
    end
    ids
  end

  def is_owned_by?(user)
    user == self
  rescue
    false
  end
end
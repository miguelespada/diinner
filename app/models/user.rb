class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include UserSearchable
  include Loggeable
  include Notificable

  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""
  field :birth, type: Date
  field :gender, type: String

  # TODO: no sería has_many?
  has_one :test_response

  def first_login?
    updated_at == created_at
  end

  def is_male?
    gender == "male"
  end
  
  def is_female?
    gender == "female"
  end

  def is_gender_undefined?
    gender == "undefined"
  end

  def opposite_sex
    if gender == "male"
      "female"
    elsif gender == "female"
      "male"
    else
      "none"
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
    user.id == id
  rescue
    false
  end
end
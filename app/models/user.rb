class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include UserSearchable

  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""
  field :birth, type: Date
  field :gender, type: String

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
end
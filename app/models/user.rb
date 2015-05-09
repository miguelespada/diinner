class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include UserSearchable

  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""
  field :birth, type: Date
  field :gender, type: String

  # TODO: no sería has_many?
  has_one :test_response

  after_create do |user|
    Log.create(:action => "new", :type => "user", :name => user.name, :entity_id => user.id)
  end

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

  def get_test_response_ids
    # TODO use significant names "ret?"
    ret = []
    TestResponse.where(user: self).each do |response|
      ret.push(response.test.id)
    end
    ret
  end
end
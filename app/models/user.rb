class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include UserSearchable

  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""

  # TODO check timestamps
  field :first_login, type: Boolean, default: true

  # TODO why there is default birhtday
  field :birth, type: Date, default: Date.today
  # TODO create is_male?
  field :gender, type: Boolean, default: false
end
class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String, default: ""
  field :image_url, type: String, default: ""
  field :name, type: String, default: ""
  field :first_login, type: Boolean, default: true
  field :birth, type: Date, default: Date.today
  field :gender, type: Boolean, default: 0
end
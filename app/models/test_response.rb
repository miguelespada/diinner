class TestResponse
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, autosave: :true
  belongs_to :test, autosave: :true

  field :response, type: String
end
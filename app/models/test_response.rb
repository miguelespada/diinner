class TestResponse
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :test, autosave: true
  belongs_to :user, autosave: true
  field :response, type: Integer
end
class TestResponse
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common
  after_destroy :remove_activities

  belongs_to :user, autosave: :true
  belongs_to :test, autosave: :true

  field :response, type: String

end
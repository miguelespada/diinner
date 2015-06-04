class TestResponse
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common

  belongs_to :user, autosave: :true
  belongs_to :test, autosave: :true

  field :response, type: String

  def notify action
    self.create_activity key: "TestResponse.#{action}", owner: user
  end
end
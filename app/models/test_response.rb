class TestResponse
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common

  after_destroy :remove_activities

  def remove_activities
    # TODO dry this
    PublicActivity::Activity.where(recipient: id).delete_all
    PublicActivity::Activity.where(owner: id).delete_all
    PublicActivity::Activity.where(trackable: id).delete_all
  end



  belongs_to :user, autosave: :true
  belongs_to :test, autosave: :true

  field :response, type: String

  def notify action
    self.create_activity key: "TestResponse.#{action}", owner: user, recipient: Admin.first
  end
end
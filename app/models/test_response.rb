class TestResponse
  include Mongoid::Document
  include Mongoid::Timestamps
  include PublicActivity::Common
  after_destroy :remove_activities

  belongs_to :user, autosave: :true
  belongs_to :test, autosave: :true

  field :response, type: String
  
  delegate :expectativas, 
           :cultura, 
           :foodie, 
           :frikismo, 
           :estudios, 
           :belleza, 
           :humor, 
           :to => :test

  def response_is_a?
    response == test.caption_A
  end

  def response_is_b?
    response == test.caption_B
  end

  def skipped?
    response == "skip"
  end
end
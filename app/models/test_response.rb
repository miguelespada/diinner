class TestResponse
  include Mongoid::Document
  include Mongoid::Timestamps

  # TODO is autosave necessary?
  belongs_to :test, autosave: true
  belongs_to :user, autosave: true
  # TODO store option label -> more semantic class, do no enconde when possible
  field :response, type: Integer
end
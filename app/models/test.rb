class Test
  include Mongoid::Document
  include Mongoid::Timestamps

  field :question, type: String, default: ""
end
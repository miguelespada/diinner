class Test
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum

  field :question, type: String, default: ""
  field :caption_A, type: String, default: ""
  field :caption_B, type: String, default: ""
  has_attachment :option_A, accept: [:jpg, :png, :gif]
  has_attachment :option_B, accept: [:jpg, :png, :gif]
  # TODO: do not add features without a test
  enum :gender, [:male, :female, :undefined]

  has_one :test_response
end
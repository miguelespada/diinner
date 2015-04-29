class Test
  include Mongoid::Document
  include Mongoid::Timestamps

  field :question, type: String, default: ""
  field :caption_A, type: String, default: ""
  field :caption_B, type: String, default: ""
  has_attachment :option_A, accept: [:jpg, :png, :gif]
  has_attachment :option_B, accept: [:jpg, :png, :gif]
end
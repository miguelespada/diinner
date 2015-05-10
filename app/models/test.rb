class Test
  include Mongoid::Document
  include Mongoid::Timestamps

  field :question, type: String, default: ""
  field :caption_A, type: String, default: ""
  field :caption_B, type: String, default: ""
  has_attachment :option_A, accept: [:jpg, :png, :gif]
  has_attachment :option_B, accept: [:jpg, :png, :gif]
  # TODO: do not add features without a test
  field :gender, type: String

  has_one :test_response

  def is_male?
    gender == "male"
  end

  def is_female?
    gender == "female"
  end

  def is_gender_undefined?
    gender == "undefined"
  end
end
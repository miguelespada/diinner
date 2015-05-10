class Test
  include Mongoid::Document
  include Mongoid::Timestamps

  field :question, type: String
  field :caption_A, type: String
  field :caption_B, type: String

  validates_presence_of :question, :caption_A, :caption_B

  has_attachment :option_A, accept: [:jpg, :png, :gif]
  has_attachment :option_B, accept: [:jpg, :png, :gif]
  # TODO: do not add features without a test
  field :gender, type: String

  # TODO: this should be has_many?
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
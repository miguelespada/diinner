class Test
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum

  field :question, type: String

  # TODO MOVE TO DIFFERENT MODEL
  field :caption_A, type: String
  field :caption_B, type: String

  validates_presence_of :question, :caption_A, :caption_B

  has_attachment :option_A, accept: [:jpg, :png, :gif]
  has_attachment :option_B, accept: [:jpg, :png, :gif]

  # TODO: do not add features without a test
  enum :gender, [:male, :female, :undefined]

  has_many :responses, class_name: "TestResponse"

  def to_ionic_json
    {
        id: self.id.to_s,
        gender: self.gender,
        question: self.question,
        caption_A: self.caption_A,
        caption_B: self.caption_B,
        photo_A: Cloudinary::Utils.cloudinary_url(self.option_A.path),
        photo_B: Cloudinary::Utils.cloudinary_url(self.option_B.path)

    }
  end
end
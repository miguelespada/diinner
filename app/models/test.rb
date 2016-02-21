class Test
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Enum

  field :question, type: String

  # TODO MOVE TO DIFFERENT MODEL
  field :caption_A, type: String
  field :caption_B, type: String

  field :expectativas, type: Integer
  field :cultura, type: Integer
  field :foodie, type: Integer
  field :frikismo, type: Integer
  field :estudios, type: Integer
  field :belleza, type: Integer
  field :humor, type: Integer

  validates_presence_of :question

  has_attachment :option_A, accept: [:jpg, :png, :gif]
  has_attachment :option_B, accept: [:jpg, :png, :gif]

  enum :gender, [:male, :female, :undefined]

  has_many :responses, class_name: "TestResponse", :dependent => :destroy

  after_create :flush_cache

  def flush_cache
    Rails.cache.delete("tests_male")
    Rails.cache.delete("tests_female")
  end

  def self.cached_tests gender  
    Rails.cache.fetch("tests_" + gender.to_s, expires_in: 1.week) do
      Test.where(_gender: gender).map{|m| m.id} + Test.where(_gender: :undefined).map{|m| m.id}
    end
  end


  def to_ionic_json
    {
        id: id.to_s,
        gender: gender,
        question: question,
        caption_A: caption_A,
        caption_B: caption_B,
        photo_A: Cloudinary::Utils.cloudinary_url(option_A.path),
        photo_B: Cloudinary::Utils.cloudinary_url(option_B.path)
    }
  end
end
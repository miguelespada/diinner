FactoryGirl.define do
  factory :test do
    sequence(:question) { |n| "Test question #{n}?" }
    caption_A "Response A"
    caption_B "Response B"
    expectativas 0
    cultura 0
    melomania 0
    foodie 0
    estudios 0
    belleza 0
    humor 0
    gender { :undefined }

    # Note building images is very slow, by default we use no image to speed up rspecs
    trait :with_images do
        option_A FactoryGirl.build(:attachinary)
        option_B FactoryGirl.build(:attachinary)
    end
  end
end
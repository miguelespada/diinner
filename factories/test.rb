FactoryGirl.define do
  factory :test do
    sequence(:question) { |n| "Test question #{n}?" }
    caption_A "Response A"
    caption_B "Response B"
    extraversion 0
    educacion 0
    hipsterismo 0
    freakismo 0
    gender { :undefined }

    # Note building images is very slow, by default we use no image to speed up rspecs
    trait :with_images do
        option_A FactoryGirl.build(:attachinary)
        option_B FactoryGirl.build(:attachinary)
    end
  end
end
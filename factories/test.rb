FactoryGirl.define do
  factory :test do
    sequence(:question) { |n| "Test question #{n}?" }
    caption_A "Response A"
    caption_B "Response B"
    option_A FactoryGirl.build(:attachinary)
    option_B FactoryGirl.build(:attachinary)
    gender { :undefined }
  end
end
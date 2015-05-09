FactoryGirl.define do
  factory :test do
    sequence(:question) { |n| "Test question #{n}?" }
    sequence(:caption_A) { |n| "Response A #{n}" }
    sequence(:caption_B) { |n| "Response B #{n}" }
    option_A FactoryGirl.build(:attachinary)
    option_B FactoryGirl.build(:attachinary)
    gender { ["undefined"] }
  end
end
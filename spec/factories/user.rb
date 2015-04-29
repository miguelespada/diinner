FactoryGirl.define do
  factory :user do
    sequence(:email)  { |n| "user_#{n}@gmail.com" }
    sequence(:image_url) { |n| "user_#{n}.jpg" }
    sequence(:name)  { |n| "user_#{n}" }
    gender { ["male", "female", "undefined"].sample }
    birth { (18..50).to_a.sample.years.seconds.ago }
  end
end
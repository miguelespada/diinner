FactoryGirl.define do
  factory :user do
    email { |n| "user_#{n}@gmail.com" }
    image_url { |n| "user_#{n}.jpg" }
    name { |n| "user_#{n}" }
    first_login { false }
    gender { [true, false].sample }
    birth { (18..40).to_a.sample.years.seconds.ago }
  end
end
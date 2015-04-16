FactoryGirl.define do
  factory :user do
    email { |n| "user_#{n}@gmail.com" }
    image_url { |n| "user_#{n}.jpg" }
    name { |n| "user_#{n}" }
  end
end
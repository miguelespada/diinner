FactoryGirl.define do
  factory :restaurant do
    sequence(:email) { |n| "restaurant_#{n}@diinner.com" }
    sequence(:name) { |n| "restaurant_#{n}" }
    password               "12345678"
    password_confirmation  "12345678"
  end
end
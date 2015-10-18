FactoryGirl.define do
  factory :reservation do
    user :user
    table :table
    date Date.today
    after_plan true
    trait :paid do
      paid true
    end
  end
end
FactoryGirl.define do
  factory :reservation do
    user :user
    table :table
    price 20
    date Date.today
    trait :paid do
      paid :true
    end
  end
end
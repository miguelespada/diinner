FactoryGirl.define do
  factory :reservation do
    user :user
    table :table
    price 20
    date Date.today
  end
end
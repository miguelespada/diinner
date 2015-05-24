FactoryGirl.define do
  factory :restaurant do
    sequence(:email) { |n| "restaurant_#{n}@diinner.com" }
    sequence(:name) { |n| "restaurant_#{n}" }
    password               "12345678"
    password_confirmation  "12345678"
    description "dummy description"
    city  "Madrid"

    trait :with_photo do
      photo FactoryGirl.build(:attachinary)
    end

    trait :with_tables do
      ignore do
        tables_count 1
      end

      after(:create) do |restaurant, evaluator|
        create_list(:menu, 1, restaurant: restaurant)
        create_list(:table, evaluator.tables_count, restaurant: restaurant)
      end
    end
  end
end
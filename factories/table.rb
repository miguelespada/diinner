FactoryGirl.define do
  factory :table do
    date Date.tomorrow
    hour Time.parse("19:00")

    trait :for_today do
      date Date.today
    end
  end
end
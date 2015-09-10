FactoryGirl.define do
  factory :table do
    date Date.tomorrow
    hour Time.parse("19:00")

    trait :for_today do
      date Date.today
    end
    
    trait :for_tomorrow do
      date Date.tomorrow
    end

    trait :for_yesterday do
      date 1.day.ago.to_date
    end
  end
end
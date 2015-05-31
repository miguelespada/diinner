FactoryGirl.define do
  factory :user do
    sequence(:email)  { |n| "user_#{n}@gmail.com" }
    sequence(:image_url) { |n| "user_#{n}.jpg" }
    sequence(:name)  { |n| "user_#{n}" }
    gender :male
    birth { (18..50).to_a.sample.years.seconds.ago }

    trait :with_customer_id do
      customer :stripe_123
    end

    trait :returning do
      updated_at 0
      created_at 1
    end

    trait :first_login do
      updated_at 0
      created_at 0
    end
  end
end
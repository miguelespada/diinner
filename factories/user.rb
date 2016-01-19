FactoryGirl.define do
  factory :user do
    sequence(:email)  { |n| "user_#{n}@gmail.com" }
    sequence(:image_url) { |n| "https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=350&h=150" }
    sequence(:name)  { |n| "user_#{n}" }
    gender :male
    birth { 20.years.ago }
    notifications_read_at { 1.month.ago }

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
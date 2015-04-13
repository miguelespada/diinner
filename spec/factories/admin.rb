FactoryGirl.define do
  factory :admin do
    email                  "admin@diinner.com"
    password               "12345678"
    password_confirmation  "12345678"
  end
end
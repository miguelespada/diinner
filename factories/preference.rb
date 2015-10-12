FactoryGirl.define do
  factory :preference do
    max_age 40
    min_age 20
    menu_range :lowcost
    city :city
  end
end
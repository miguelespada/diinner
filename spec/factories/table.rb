FactoryGirl.define do
  factory :table do
    date { (5..15).to_a.sample.days.seconds.from_now }
  end
end
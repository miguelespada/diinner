FactoryGirl.define do
  factory :table do
    #  TODO --> NEVER use sample on factories
    #  makes test non deterministic
    #  you can use sample on fake
    # date { (5..15).to_a.sample.days.seconds.from_now }
    date Date.today
    hour Time.parse("19:00")
  end
end
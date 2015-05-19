FactoryGirl.define do
  factory :attachinary, class:Hash  do
    sequence(:public_id ) { |n| "id_#{n}" }
    version "1"
    width 500 
    height 100
    format "jpg"
    resource_type "image" 

    initialize_with { attributes } 
  end
end
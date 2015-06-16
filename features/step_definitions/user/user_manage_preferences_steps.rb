When(/^I change my preferences$/) do
  FactoryGirl.create(:city, name: "madrid")
  FactoryGirl.create(:city, name: "barcelona")
  click_on "Preferences dinner"
  fill_in "user_preference_attributes_max_age", with: "60"
  fill_in "user_preference_attributes_min_age", with: "20"
  select "40", :from => "user_preference_attributes_menu_price"
  select :barcelona, :from =>  "user_preference_attributes_city_id"
  click_on "Update User"
  expect(page).to have_content "20...60"
  expect(page).to have_content "40"
end

Then(/^I see my preferences applied to the table search$/) do
  click_on "New reservation"
  expect(page).to have_select('reservation_city', selected: "barcelona")
end
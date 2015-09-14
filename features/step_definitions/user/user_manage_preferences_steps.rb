When(/^I can see the default preferences$/) do
  click_on "Preferences diinner"
  click_on "Update User"
  expect(page).to have_content "18...30"
  # TODO add rest of defaults
end


When(/^I change my preferences$/) do
  FactoryGirl.create(:city, name: "madrid")
  FactoryGirl.create(:city, name: "barcelona")
  click_on "Preferences diinner"
  fill_in "user_preference_attributes_max_age", with: "60"
  fill_in "user_preference_attributes_min_age", with: "20"
  choose "Go for drinks"
  select "40", :from => "user_preference_attributes_menu_price"
  select :barcelona, :from =>  "user_preference_attributes_city_id"
  click_on "Update User"

  expect(page).to have_content "20...60"
  expect(page).to have_content "40"
  expect(page).to have_content "Go for drinks"
end

Then(/^I see my preferences applied to the table search$/) do
  click_on "New reservation"
  expect(page).to have_select('reservation_city', selected: "barcelona")
  # TODO add rest of defaults
end
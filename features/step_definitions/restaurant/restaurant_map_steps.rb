When(/^I visit my profile page$/) do
  visit restaurant_path(@restaurant)
end

Then(/^I should see a map$/) do
  expect(page).to have_css "#map"
end

When(/^I add a geolocation to my profile$/) do
  visit edit_restaurant_path(@restaurant)
  ajax_call :google_api 
  click_on "Update Restaurant"
end

Then(/^I should see my geolocation$/) do
  expect(page).to have_content "40.012345"
  expect(page).to have_content "5.056789"
end

Then(/^I should see my location marked in the map$/) do
  expect(page).to have_css ".leaflet-marker-icon"
end
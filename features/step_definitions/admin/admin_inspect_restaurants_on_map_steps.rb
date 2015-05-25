Then(/^I should see the restaurants on a map$/) do
  click_on "Map"
  select "Madrid", :from => 'city_city'
  expect(page).to have_selector('#markers .location', count: 3)
  expect(page).to have_selector('#map')
end
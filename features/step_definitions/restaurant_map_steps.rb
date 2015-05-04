Then(/^I should see a map$/) do
  expect(page).to have_css "#restaurant-map"
end
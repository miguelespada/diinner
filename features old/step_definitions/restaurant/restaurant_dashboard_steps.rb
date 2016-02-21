When(/^I go to restaurant dashboard$/) do
  visit restaurant_path(@restaurant)
end

Then(/^I should see all the restaurant navigation controls$/) do
  expect(page).to have_link "Tables"
  expect(page).to have_link "Menus"
end
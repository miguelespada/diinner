When(/^I go to my dashboard$/) do
  visit admin_path
end

Then(/^I should see all the navigation controls$/) do
  expect(page).to have_link "Restaurants"
  expect(page).to have_link "Tables"
  expect(page).to have_link "Menus"
  expect(page).to have_link "Users"
  expect(page).to have_link "Tests"
  expect(page).to have_link "Logs"
end
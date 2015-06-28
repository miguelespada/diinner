When(/^I reserve a table in ionic$/) do
  click_on "New reservation"
  expect(page).to have_content("New reservation")
  expect(page).to have_content("What do you expect of the diinner?")
end
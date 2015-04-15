When(/^I go to my profile page$/) do
  click_on "Profile"
end

Then(/^I should see my profile$/) do
  expect(page).to have_content "My profile"
  expect(page).to have_content "Description"
  expect(page).to have_content "Phone number"
  expect(page).to have_content "Address"
end
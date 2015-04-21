When(/^I go to my profile page$/) do
  click_on "Profile"
end

Then(/^I should see my profile$/) do
  expect(page).to have_content "My profile"
  expect(page).to have_content "Description"
  expect(page).to have_content "Phone number"
  expect(page).to have_content "Address"
end

When(/^I click to edit my profile$/) do
  step "I go to my profile page"
  click_on "Edit my profile"
end

Then(/^I change my profile$/) do
  fill_in "Name", with: "Dummy restaurant"
  fill_in "Description", with: "Dummy description"
  fill_in "Phone", with: "12345678"
  fill_in "Address", with: "Dummy street 1"
  click_on "Update Restaurant"
end

Then(/^I should see my profile has been updated$/) do
  expect(page).to have_content "Dummy restaurant"
  expect(page).to have_content "Description: Dummy description"
  expect(page).to have_content "Phone number: 12345678"
  expect(page).to have_content "Address: Dummy street 1"
end

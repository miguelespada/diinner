Given(/^I can access to the user page$/) do
  FactoryGirl.create(:user, name: "Javier", email: "javier@gmail.com")
  visit "http://localhost:8100/"
  click_on "User"
end

Then(/^I should be able to see my profile details$/) do
  expect(page).to have_content("Javier")
  expect(page).to have_content("javier@gmail.com")
end

And(/^I should be able to see the user links$/) do
  expect(page).to have_content("My profile")
  expect(page).to have_content("New reservation")
  expect(page).to have_content("My reservations")
  expect(page).to have_content("Last minute plan")
end

Given(/^I access to the profile page$/) do
  click_on "My profile"
  expect(page).to have_content("My profile")
end

Then(/^I should be able to see the profile links$/) do
  expect(page).to have_content("Diinner preferences")
  expect(page).to have_content("Need help?")
  expect(page).to have_content("Share Diinner")
end
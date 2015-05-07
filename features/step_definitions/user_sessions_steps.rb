Then(/^I should see the user login panel$/) do
  page.should have_css "#login-panel"
end

Given(/^I am a logged user$/) do
  @user = FactoryGirl.create(:user, :returning, name: "Rodrigo")
  login_as_user @user
end

Then(/^I should see the user page$/) do
  expect(page).to have_content @user.name
end

Then(/^I should see my user data$/) do
  expect(page).to have_content @user.name
  expect(page).to have_css ".avatar"
end


When(/^I go to the user page$/) do
  visit users_path
end

When(/^I add an address to my profile$/) do
end
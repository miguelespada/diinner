When(/^I go to the user page$/) do
  visit users_path
end

Then(/^I should see the user login panel$/) do
  page.should have_css "#login-panel"
end

Given(/^I am a logged user$/) do
  @user = FactoryGirl.create(:user, name: "Rodrigo")
  login_as_user @user
end

Then(/^I should see the user page$/) do
  expect(page).to have_content "User page"
end

Then(/^I should see my user data$/) do
  expect(page).to have_content @user.name
  expect(page).to have_css ".avatar"
end



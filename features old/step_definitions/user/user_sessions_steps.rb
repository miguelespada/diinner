Then(/^I should see the user login panel$/) do
  page.should have_css "#login-panel"
end

Given(/^I am a logged user$/) do
  @user = FactoryGirl.create(:user, :returning)
  login_as_user @user
  visit users_path
end

Then(/^I should see the user page$/) do
  expect(page).to have_content @user.name
end

When(/^I go to the user page$/) do
  visit users_path
end

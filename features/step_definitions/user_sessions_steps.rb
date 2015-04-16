When(/^I go to the user page$/) do
  visit users_path
end

Then(/^I should see the user login panel$/) do
  page.should have_css "#login-panel"

end

Given(/^I am a user$/) do
  @user = FactoryGirl.create(:user)
end

Then(/^I should have user data$/) do
  @user.name = "José Luis"
  @user.email = "user@example.com"
end

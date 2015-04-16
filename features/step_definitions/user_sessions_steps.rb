When(/^I go to the user page$/) do
  visit users_show_path
end

Then(/^I should see the user login panel$/) do
  page.should have_css "#login-panel"
end

Given(/^I am a user$/) do
  @user = FactoryGirl.create(:user, name: "Rodrigo")
  UserSession.any_instance.should_receive(:logged?).and_return(true)
  UserSession.any_instance.should_receive(:user_from_session).and_return(@user)
end

Then(/^I should have user data$/) do
  page.should have_content "User logged"
  page.should have_content "Welcome #{@user.name}"
end

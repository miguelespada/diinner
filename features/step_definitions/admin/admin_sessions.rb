
Then(/^I should see Hello World$/) do
  be_at_homepage
end

Given(/^I am admin$/) do
  @admin = FactoryGirl.create(:admin)
end

When(/^I login as admin$/) do
 login_as_admin @admin
end

Then(/^I should see my personal admin space$/) do
  within(:css, ".user-name") do
    should have_content "Admin"
  end
end

When(/^I go to the admin page$/) do
  visit admin_path
end

Then(/^I should not see the admin page$/) do
  expect(page).to have_content "You need to sign in or sign up before continuing."
end

Given(/^I am logged as admin$/) do
  login_as_admin FactoryGirl.create(:admin)
end

When(/^I change my admin password$/) do
  click_on "Change password"
  fill_in "Current password", with: "12345678"
  fill_in "Password", with: "updated1111"
  fill_in "Password confirmation", with: "updated1111"
  click_on "Update"
end

Then(/^I should see that my admin password has changed$/) do
  click_on "Admin"
  step "I logout"
  click_on "Admin"
  fill_in "Email", with: "admin@diinner.com"
  fill_in "Password", with: "updated1111"
  click_button 'Log in'
  expect(page).to have_content "Signed in successfully."
end



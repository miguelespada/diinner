def be_at_homepage
  expect(page).to have_content "Hello world!"
end

Given(/^I am guest$/) do
end

When(/^I visit the homepage$/) do
  visit root_path
end

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
  expect(page).to have_content "Admin Page"
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

When(/^I logout$/) do
  click_on "Logout"
end

Then(/^I should see the homepage$/) do
  be_at_homepage
end

Given(/^I am guest$/) do
end

When(/^I visit the homepage$/) do
  visit root_path
end

Then(/^I should see Hello World$/) do
  expect(page).to have_content "Hello world!"
end

Given(/^I am admin$/) do
  @admin = FactoryGirl.create(:admin)
end

When(/^I login$/) do
  visit new_admin_session_path
  fill_in "Email", with: @admin.email
  fill_in "Password", with: @admin.password
  click_button 'Log in'
end

Then(/^I should see my personal space$/) do
  expect(page).to have_content "Admin Page"
end

When(/^I go to the admin page$/) do
  visit admin_path
end

Then(/^I should not see the admin page$/) do
  expect(page).to have_content "You need to sign in or sign up before continuing."
end

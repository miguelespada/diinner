Given(/^I am guest$/) do
end

When(/^I visit the homepage$/) do
  visit root_path
end

Then(/^I should see Hello World$/) do
  expect(page).to have_content "Hello world!"
end


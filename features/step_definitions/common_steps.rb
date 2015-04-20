def be_at_homepage
  expect(page).to have_content "Hello diinner!"
end

Given(/^I am guest$/) do
end

When(/^I visit the homepage$/) do
  visit root_path
end


When(/^I logout$/) do
  click_on "Logout"
end

Then(/^I should see the homepage$/) do
  be_at_homepage
end

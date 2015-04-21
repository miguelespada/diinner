Given(/^I am a restaurant$/) do
  @restaurant = FactoryGirl.create(:restaurant)
end

When(/^I login as restaurant$/) do
 login_as_restaurant @restaurant
end

Then(/^I should see my personal restaurant space$/) do
  expect(page).to have_content "Hello restaurant!"
end

When(/^I go to the restaurant page$/) do
  visit restaurants_path
end

Then(/^I should not see the restaurant page$/) do
  expect(page).to have_content "You need to sign in or sign up before continuing."
end

Given(/^I am logged as restaurant$/) do
  step "I am a restaurant"
  step "I login as restaurant"
end
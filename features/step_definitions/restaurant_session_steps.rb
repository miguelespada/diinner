Given(/^I am a restaurant$/) do
  @restaurant = FactoryGirl.create(:restaurant)
end

When(/^I login as restaurant$/) do
 login_as_restaurant @restaurant
end

Then(/^I should see my personal restaurant space$/) do
  expect(page).to have_content "Hello restaurant!"
end
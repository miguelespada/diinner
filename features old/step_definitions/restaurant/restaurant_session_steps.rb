Given(/^I am a restaurant$/) do
  city = FactoryGirl.create(:city)
  @restaurant = FactoryGirl.create(:restaurant, city: city)
end

When(/^I login as restaurant$/) do
 login_as_restaurant @restaurant
end

Then(/^I should see my personal restaurant space$/) do
  expect(page).to have_css ".calendar"
  within('.user-name') do
    should have_content @restaurant.name
  end
end

When(/^I go to the restaurant page$/) do
  visit restaurants_path
end

Then(/^I should not see the restaurant page$/) do
  expect(page).to have_content "You need to sign in or sign up before continuing."
end

Given(/^I am logged as restaurant$/) do
  city = FactoryGirl.create(:city)
  @restaurant = FactoryGirl.create(:restaurant, city: city)
  login_as_restaurant @restaurant
end
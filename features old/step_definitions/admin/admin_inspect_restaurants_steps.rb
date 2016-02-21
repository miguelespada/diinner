Given(/^A restaurant has recently logged$/) do
  @restaurant = FactoryGirl.create(:restaurant)
  login_as_restaurant @restaurant
  click_on "Logout"
end

Then(/^I should see the restaurant activity$/) do
  click_on "Restaurants"
  within(:css, ".restaurant-status") do
    expect(page).to have_content "Last time active: less than a minute"
  end
end
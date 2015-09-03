Given(/^There are some last minute diinners$/) do
  @city = FactoryGirl.create(:city)
  @restaurant = FactoryGirl.create(:restaurant, city: @city)
  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @restaurant.tables.create(FactoryGirl.build(:table, :for_today).attributes)
  @menu = @restaurant.menus.first
  @table = @restaurant.tables.first

  he = FactoryGirl.create(:user, gender: :male)
  she = FactoryGirl.create(:user, gender: :female)

  FactoryGirl.create(:reservation, user: he, table: @table)
  FactoryGirl.create(:reservation, user: he, table: @table)
  FactoryGirl.create(:reservation, user: she, table: @table)
  FactoryGirl.create(:reservation, user: she, table: @table)

end

Given(/^I do not have prefences$/) do
  # nothing to do, by default we don't have preferences
end

When(/^I try to reserve a last minute diinner$/) do
  click_on "Last minute diinners"
end

Then(/^I should be notified that I have to fill my preferences$/) do
  expect(page).to have_content "You need to fill your diinner preferences to access the last minute diinners!"
end

Given(/^I have prefences$/) do
  click_on "Last minute diinners"

  fill_in "user_preference_attributes_max_age", with: "60"
  fill_in "user_preference_attributes_min_age", with: "20"
  select "20", :from => "user_preference_attributes_menu_price"
  select @city.name, :from =>  "user_preference_attributes_city_id"
  click_on "Update User"
end

When(/^I reserve a last minute diinner$/) do
  click_on "Last minute diinners"
  click_on "Reserve"
  step "I fill in the credit card details"
  click_on "Confirm"
  expect(page).to have_content "Table reserved succesfully!"
end

Then(/^I shoud be notified that my plan is pending$/) do
  click_on "Notifications"
  within("#logs .plan-pending-log") do
    expect(page).to have_content "Your plan diinner for tonight at #{@table.restaurant.name} is waiting for confirmation!!!"
  end
end

Given(/^They have been a reservation$/) do
  other_she = FactoryGirl.create(:user, gender: :female)
  FactoryGirl.create(:reservation, user: other_she, table: @table)
end


Then(/^I shoud be notified that my last minute plan is confirmed$/) do
  click_on "Notifications"
  within("#logs .plan-confirmed-log") do
    expect(page).to have_content "Your plan diinner for tonight at #{@table.restaurant.name} is confirmed!!!"
  end
end

Then(/^I can access to the reservation through my reservations$/) do
  click_on "My reservations"
  within(".calendar .today") do
    click_on @table.hour.hour
  end
  within(".reservation-status") do
    save_and_open_page
    expect(page).to have_content "Confirmed"
  end

  expect(page).not_to have_content "Cancel reservation"
end


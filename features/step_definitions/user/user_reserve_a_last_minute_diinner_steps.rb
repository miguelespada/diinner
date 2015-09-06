Given(/^There are some last minute diinners$/) do
  @city = FactoryGirl.create(:city)
  @restaurant = FactoryGirl.create(:restaurant, city: @city)
  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @restaurant.tables.create(FactoryGirl.build(:table, :for_today).attributes)
  @menu = @restaurant.menus.first
  @table = @restaurant.tables.first

  he = FactoryGirl.create(:user, :with_customer_id,  gender: :male)
  she = FactoryGirl.create(:user, :with_customer_id,  gender: :female)

  FactoryGirl.create(:reservation, user: he, table: @table, date: 1.days.ago)
  FactoryGirl.create(:reservation, user: he, table: @table, date: 2.days.ago)
  FactoryGirl.create(:reservation, user: she, table: @table, date: 3.days.ago)
  FactoryGirl.create(:reservation, user: she, table: @table, date: 4.days.ago)
  
  return_value = Hash.new
  return_value[:id] = "123"
  allow_any_instance_of(Reservation).to receive(:create_stripe_charge) do |entity|
    entity.user.customer ? return_value : nil
  end
  allow_any_instance_of(Reservation).to receive(:stripe_capture).and_return return_value
  allow_any_instance_of(Reservation).to receive(:stripe_refund).and_return return_value 

  TableManager.process_today_tables
end


Given(/^I have preferences$/) do
  click_on "Preferences diinner"

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

Then(/^I can access to the pending reservation through my reservations$/) do
  click_on "My reservations"
  within(".calendar .today") do
    click_on @table.hour.hour
  end
  within(".reservation-status") do
    expect(page).to have_content "STATUS Pending"
  end
end

Then(/^I shoud be notified that my plan is pending$/) do
  click_on "Notifications"
  within("#logs .plan-pending-log") do
    expect(page).to have_content "Your plan diinner for tonight at #{@table.restaurant.name} is waiting for confirmation!!!"
  end
end

Given(/^They have been a reservation$/) do
  @other_she = FactoryGirl.create(:user, :with_customer_id, gender: :female)
  FactoryGirl.create(:reservation, user: @other_she, table: @table)
end

Then(/^I should be notified that my last minute plan is confirmed$/) do
  click_on "Notifications"
  within("#logs .plan-confirmed-log") do
    expect(page).to have_content "Your plan diinner for tonight at restaurant #{@table.restaurant.name} is confirmed!!!"
  end
end

Then(/^I can access to the confirmed reservation through my reservations$/) do
  click_on "My reservations"
  within(".calendar .today") do
    click_on @table.hour.hour
  end
  within(".reservation-status") do
    expect(page).to have_content "STATUS Confirmed"
  end
end

Then(/^I cannot cancel the reservation$/) do
  expect(page).not_to have_content "Cancel reservation"
end

Then(/^The other user can see the confirmed last minute reservation$/) do
  step "I logout"
  login_as_user @other_she
  visit users_path
  step "I can access to the confirmed reservation through my reservations"
end

Then(/^The restaurant should be see the confirmed last minute reservation$/) do
  step "I logout"
  login_as_restaurant @restaurant
  click_on "Reservations"
  expect(page).to have_content @user.name
  expect(page).to have_content @other_she.name
end

Then(/^The admin should see the confirmed last minute reservation$/) do
  step "I logout"
  step "I am logged as admin"
  click_on "Reservations"
  expect(page).to have_content @user.name
  expect(page).to have_content @other_she.name
end

Given(/^There are some tables$/) do
  city = FactoryGirl.create(:city)
  restaurant = FactoryGirl.create(:restaurant, city: city)
  restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  restaurant.tables.create(FactoryGirl.build(:table, :for_yesterday).attributes)
  restaurant.tables.create(FactoryGirl.build(:table, :for_today).attributes)
  restaurant.tables.create(FactoryGirl.build(:table, :for_tomorrow).attributes)

  he = FactoryGirl.create(:user)
end

When(/^I batch delete the tables$/) do
  find(".settings").click
  click_on "Remove old tables"
end

Then(/^I should not see the old tables$/) do
  expect(page).to have_content "1 table(s) removed!"
end

Then(/^I can process a table$/) do
  click_on "Tables"
  click_on "Process"
  expect(page).to have_content "Processed"
  click_on "Payments"
  expect(page).to have_content "Confirmed"
end

Then(/^I can't process the same table twice$/) do
  click_on "Tables"
  click_on "Process"
  expect(page).to have_content "Processed"
end


Given(/^There are not enough reservations$/) do
  step "There are some available tables"
  @he = FactoryGirl.create(:user, :with_customer_id, gender: :male)
  @she = FactoryGirl.create(:user, :with_customer_id, gender: :female)

  return_value = Hash.new
  return_value[:id] = "123"
  allow_any_instance_of(Reservation).to receive(:create_stripe_charge).and_return return_value
  allow_any_instance_of(Reservation).to receive(:stripe_capture).and_return return_value
  allow_any_instance_of(Reservation).to receive(:stripe_refund).and_return return_value

  FactoryGirl.create(:reservation, user: @he, table: @table)
  FactoryGirl.create(:reservation, user: @he, table: @table)
  FactoryGirl.create(:reservation, user: @she, table: @table)
end

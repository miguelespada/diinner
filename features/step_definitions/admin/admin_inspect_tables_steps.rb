Given(/^a restaurant has created a table$/) do
  @restaurant = FactoryGirl.create(:restaurant)
  @table = @restaurant.tables.create
  @table.menu =  FactoryGirl.create(:menu)
  @table.save! 
end

Then(/^I should see the table in the tables list$/) do
  click_on "Tables"
  expect(page).to have_content @restaurant.name
  expect(page).to have_content @table.locator
  expect(page).to have_content "3/3"
end


Given(/^A user has reserved a table$/) do
  step "I am a logged user"
  step "There are some available tables"
  step "I reserve a table"
end

Then(/^I can see the user reservation in the table section$/) do
  click_on "Tables"
  within "#content" do
    click_on @table.locator
  end
  within('.reservations') do
    expect(page).to have_content @user.name
  end
end

Given(/^There enough reservations$/) do

  table = Table.first

  he = FactoryGirl.create(:user, :with_customer_id, gender: :male)
  she = FactoryGirl.create(:user, :with_customer_id, gender: :female)

  reservation = FactoryGirl.create(:reservation, user: he, table: table, date: 2.days.ago)
  reservation.save!

  reservation = FactoryGirl.create(:reservation, user: she, table: table, date: 1.days.ago)
  reservation.companies.create(age: 30, gender: :female)
  reservation.save!

  return_value = Hash.new
  return_value[:id] = "123"
  allow_any_instance_of(Reservation).to receive(:create_stripe_charge) do |entity|
    entity.user.customer ? return_value : nil
  end
  allow_any_instance_of(Reservation).to receive(:stripe_capture).and_return return_value
  allow_any_instance_of(Reservation).to receive(:stripe_refund).and_return return_value 

end

Then(/^I can see that the reservation is paid$/) do
  click_on "Reservations"
  expect(page).to have_content "Confirmed"
end


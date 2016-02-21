Given(/^They have been a reservation with error$/) do
  # ther reservation has not customer id so the payment will have an error
  @other_she = FactoryGirl.create(:user, gender: :female)
  FactoryGirl.create(:reservation, user: @other_she, table: @table)
end


When(/^The other user can see the cancelled last minute reservation$/) do
  step "I logout"
  login_as_user @other_she
  visit users_path
  step "I can access to the cancelled reservation through my reservations"
end

When(/^I can access to the cancelled reservation through my reservations$/) do
  click_on "My reservations"
  within(".calendar .today") do
    click_on @table.hour.hour
  end
  within(".reservation-status") do
    expect(page).to have_content "STATUS Cancelled"
  end
end

When(/^There is an error processing my credit card$/) do
  allow_any_instance_of(User).to receive(:update_customer_information!) do |user|
    user.customer = nil
    true
  end
end

When(/^I reserve a last minute diinner with error$/) do
  click_on "New Reservation", match: :first
  select("Lowcost", :from => "reservation_price")
  select "Madrid", :from => "reservation_city"
  find("#reservation_date", visible: false).set Date.today #TODO CHECK IF GOOD
  click_on "Search tables"
  click_on @restaurant.name
  step "I fill in the credit card details"
  step "There is an error processing my credit card"
  click_on "Confirm"
end

Then(/^I should be notified that my last minute plan is cancelled$/) do
  expect(page).to have_content "There was an error processing your reservation :("
end

Then(/^The other user can see the pending last minute reservation$/) do
 step "I logout"
  login_as_user @other_she
  visit users_path
  step "I can access to the pending reservation through my reservations"
end

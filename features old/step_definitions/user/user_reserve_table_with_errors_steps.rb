When(/^I try to reserve a table$/) do
  step("I search a table")
  click_on @table.restaurant.name
  step("I fill in the credit card details")
end

When(/^Stripe cannot create the customer information$/) do
  allow_any_instance_of(User).to receive(:update_customer_information!).and_return(false)
  click_on "Confirm"
end

Then(/^I shoud not see the reservation in my reservations$/) do
  expect(page).to have_content("There was an error processing your reservation :(")
  expect(Reservation.count).to be 0
end

When(/^I should be notified that there are no tables matching by criteria$/) do
  expect(page).to have_content "There are no diinners matching your search criteria"
end

When(/^I search a table with no matchs$/) do

  step "I go to the user page"
  click_on "New Reservation", match: :first
  select("Lowcost", :from => "reservation_price")
  find("#reservation_date", visible: false).set 10.days.from_now.to_date
  select "Madrid", :from => "reservation_city"

  click_on "Search tables"
end
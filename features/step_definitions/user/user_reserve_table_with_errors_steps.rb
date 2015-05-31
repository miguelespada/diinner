When(/^I try to reserve a table$/) do
  step("I search a table")
  click_on("Reserve")
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
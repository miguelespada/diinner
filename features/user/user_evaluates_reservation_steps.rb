When(/^The diinner has passed$/) do
  allow_any_instance_of(Reservation).to receive(:can_be_evaluated?).and_return true
end

Then(/^I can evaluate the reservation$/) do
  click_on "My reservations"
  find(".status-table > a").click
  click_on "Evaluate"
  save_and_open_page
end
When(/^I can see the user reservation$/) do
  click_on "Reservations"
  expect(page).to have_content @user.name
  expect(page).to have_content @table.menu.name
  expect(page).to have_content @table.date
  expect(page).to have_content "Go to sleep"
  within(".slots") do
    expect(page).to have_content "1/0" #TODO FRIEND 1/1
  end
  expect(page).to have_content @table.hour.strftime("%H:%M")
  expect(page).to have_content "Pending"
end

When(/^I process reservations$/) do
  find(".settings").click
  allow(Date).to receive(:today).and_return Date.tomorrow

  click_on "Process reservations"
  expect(page).to have_content "Reservations processed succesfully!"
end

Then(/^I can see that the reservation is cancelled$/) do
  click_on "Reservations"
  expect(page).to have_content @user.name
  expect(page).to have_content "Cancelled"
end

When(/^I can see the slots left of the reserved table$/) do
  click_on "Tables"
  expect(page).to have_content @table.locator
  within(".table-slots") do
    expect(page).to have_content "2/2"
  end
end

Then(/^I can process last minute diinners$/) do
  find(".settings").click

  click_on "Process last minute diinners"
  expect(page).to have_content "Last minute diinners processed succesfully!"
end

Then(/^I cannot validate the reservation$/) do
  click_on "Reservations"
  expect(page).not_to have_content "validate"
end

When(/^The reservation is paid$/) do
   allow_any_instance_of(Reservation).to receive(:paid?).and_return true
end


Then(/^I can validate the reservation$/) do
  click_on "Reservations"
  click_on "validate"
  expect(page).to have_content "unvalidate"
  expect(page).to have_content "Validated"
end

Then(/^I can see the table cancellation in my notifications$/) do
  click_on "Notifications"
  within("#logs .cancel-table-log") do
    expect(page).to have_content "Table"
    expect(page).to have_content "for tonight was cancelled"
  end
end

Then(/^I can see the table confirmation in my notifications$/) do
  click_on "Notifications"
  within("#logs .confirmation-table-log") do
    expect(page).to have_content "Table #{@table.locator} for tonight was confirmed!!!"
  end
end

Then(/^I can search user reservation by ticket$/) do
  click_on "Tickets Diinner"
  fill_in "query", with: "XXX"
  find("#search-button").click
  expect(page).to have_content "No tickets where found"
  fill_in "query", with: Reservation.first.locator
  find("#search-button").click
  expect(page).to have_content  Reservation.first.table.locator
end



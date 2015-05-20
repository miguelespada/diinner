When(/^I can see the user reservation$/) do
  click_on "Reservations"
  expect(page).to have_content @user.name
  expect(page).to have_content @table.assigned_menu.name
  expect(page).to have_content @table.date
  expect(page).to have_content @table.hour
  expect(page).to have_content "Confirmed"
end

When(/^I process reservations$/) do
  Reservation.process
end

Then(/^I can see that the reservation is paid$/) do
  click_on "Reservations"
  expect(page).to have_content @user.name
  expect(page).to have_content "Paid"
end
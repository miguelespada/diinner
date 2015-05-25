When(/^I can see the user reservation$/) do
  click_on "Reservations"
  expect(page).to have_content @user.name
  expect(page).to have_content @table.menu.name
  expect(page).to have_content @table.date
  within(".slots") do
    expect(page).to have_content "1/1"
  end
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

When(/^I can see the slots left of the reserved table$/) do
  click_on "Tables"
  expect(page).to have_content @table.id
  within(".table-slots") do
    expect(page).to have_content "2/2"
  end
end
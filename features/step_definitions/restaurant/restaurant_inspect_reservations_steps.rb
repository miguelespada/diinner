When(/^I can see the user reservation$/) do
  click_on "Reservations"
  expect(page).to have_content @user.name
  expect(page).to have_content @table.menu.name
  expect(page).to have_content @table.date
  within(".slots") do
    expect(page).to have_content "1/1"
  end
  expect(page).to have_content @table.hour.strftime("%H:%M")
  expect(page).to have_content "Pending"
end

When(/^I process reservations$/) do
  find(".settings").click
  click_on "Process reservations"
  expect(page).to have_content "Reservations processed succesfully!"
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

Then(/^I can validate the reservation$/) do
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
    expect(page).to have_content "Table #{@table.id} for tonight was confirmed!!!"
  end
end

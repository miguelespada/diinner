Given(/^A user has cancelled a reservation$/) do
  step "There are some available tables"
  step "I am a logged user"
  step "I reserve a table"
  step "I cancel my reservation"
  step "I logout"
end

When(/^I can see the cancellation in my reservations$/) do
  click_on "Reservations"
  expect(page).to have_content @user.name
  expect(page).to have_content :undefined
  expect(page).to have_content @table.date
  within(".slots") do
    expect(page).to have_content "0/0"
  end
  expect(page).to have_content "Cancelled"
  click_on @table.id
  expect(page).to have_content "3/3"
end

When(/^I can see the cancellation in my notifications$/) do
  click_on "Notifications"
  within("#logs .cancel-reservation-log") do
    expect(page).to have_content "Reservation cancelled"
    expect(page).to have_content @user.name
  end
end

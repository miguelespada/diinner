Then(/^I can see the reservation in my notifications$/) do
  click_on "Notifications"
  within("#logs .new-reservation-log") do
    expect(page).to have_content "New reservation"
    expect(page).to have_content @user.name
  end
end

Then(/^I can access reservation data$/) do
  within("#logs .new-reservation-log .reservation-id") do
    find(".show-link").click
  end
  expect(page).to have_content "Reservation"
  expect(page).to have_content "Dummy menu"
end

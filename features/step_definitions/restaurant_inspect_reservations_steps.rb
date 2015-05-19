When(/^I can see the user reservation$/) do
  click_on "Reservations"
  expect(page).to have_content @user.name
  expect(page).to have_content "Confirmed"

end
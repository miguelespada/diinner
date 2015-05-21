When(/^I access the user data through the reservation$/) do
  click_on "Reservations"
  click_on @user.name
  expect(page).to have_content @user.name
  expect(page).to have_content @user.email
  expect(page).to have_content @user.gender
  expect(page).to have_content @user.birth
end
Then(/^I can see the user reservation in the reservation section$/) do
  click_on "Reservations"
  expect(page).to have_content @user.name
  expect(page).to have_content @restaurant.name
  expect(page).to have_content "Confirmed"

  within('.restaurant-reservation') do
    find(".show").click
  end

  step("I can see the table details")
end

Then(/^I can see the reservation in the user section$/) do
  click_on "Users"
  click_on @user.name
  within('.reservations') do
    expect(page).to have_content @restaurant.name
    expect(page).to have_content "Confirmed"
  end
end

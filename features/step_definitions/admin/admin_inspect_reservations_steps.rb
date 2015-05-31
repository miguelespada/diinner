Then(/^I can see the user reservation in the reservation section$/) do
  within(".navigation") do
    click_on "Reservations"
  end
  expect(page).to have_content @user.name
  expect(page).to have_content @restaurant.name
  expect(page).to have_content "Pending"

  within('.restaurant-reservation') do
    find(".show-link").click
  end

  step("I can see the table details")
end

Then(/^I can see the reservation in the user section$/) do
  click_on "Users"
  within "#content" do
    click_on @user.name
  end
  within('.reservations') do
    expect(page).to have_content @restaurant.name
    expect(page).to have_content "Pending"
  end
end


Then(/^I can see the reservation in the restaurant section$/) do
  click_on "Restaurants"
  within "#content" do
    click_on @restaurant.name
  end
  within('.reservations') do
    expect(page).to have_content @user.name
    expect(page).to have_content "Pending"
  end
end
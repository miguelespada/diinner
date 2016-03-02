Given(/^A user has made a reservation$/) do
  step "There are some available tables for tomorrow"
  step "I am a logged user"
  step "I make a reservation"
end


Then(/^I can see the user reservation in the reservation section$/) do
  within(".navigation") do
    click_on "Reservations"
  end
  
  expect(page).to have_content @user.name
  expect(page).to have_content @restaurant.name
  expect(page).to have_content "Go for drinks"
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

Then(/^I can see the reservation details$/) do
  within('.restaurant-reservation') do
    find(".show-link").click
  end

  within('.reservation') do
    expect(page).to have_content @restaurant.name
    expect(page).to have_content "Pending"
  end
end

Then(/^I can see the user reservation in the table section$/) do
  click_on "Tables"
  within "#content" do
    click_on @table.locator
  end
  within('.reservations') do
    expect(page).to have_content @user.name
  end
end

Then(/^I can see the table details$/) do

  expect(page).to have_content(@restaurant.name)
  
  expect(page).to have_content(@table.date)
  expect(page).to have_content(@table.hour.strftime("%H:%M"))
  expect(page).to have_content(@menu.name)

  # TODO add menu price and reservation total to the table
  # expect(page).to have_content(@menu.price)

  expect(page).to have_content("#{@table.affinity}%")
end


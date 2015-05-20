Given(/^a restaurant has created a table$/) do
  @restaurant = FactoryGirl.create(:restaurant)
  @table = @restaurant.tables.create
end

Then(/^I should see the table in the tables list$/) do
  click_on "Tables"
  expect(page).to have_content @restaurant.name
  expect(page).to have_content @table.id
  expect(page).to have_content @table.slots_left
end


Given(/^A user has reserved a table$/) do
  step "I am a logged user"
  step "There are some available tables"
  step "I reserve a table"
end

Then(/^I can see the user reservation in the table section$/) do
  click_on "Tables"
  click_on @table.id
  within('.users') do
    expect(page).to have_content @user.name
  end
end

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
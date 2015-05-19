Given(/^There are some available tables$/) do
  @restaurant = FactoryGirl.create(:restaurant, :with_tables)
  @menu = @restaurant.menus.first
  @table = @restaurant.tables.first
end

When(/^I reserve a table$/) do
  step "I go to the user page"
  click_on "New reservation"
  fill_in "Date", with: @table.date
  select(20, :from => "price")
  click_on "Search"
  step("I can see the reservation details")
  first('.result').click_link("Reserve")
  step("I fill in the credit card details")
  expect(page).to have_content("Table reserved succesfully!")
end

Then(/^I can see the reservation details$/) do
  expect(page).to have_content(@restaurant.name)
  expect(page).to have_content(@table.menu.name)
  expect(page).to have_content(@table.menu.price)
  expect(page).to have_content(@table.date)
  expect(page).to have_content(@table.hour)
  within ".affinity" do
    expect(page).to have_content("80%")
  end
end

Then(/^I fill in the credit card details$/) do
  fill_in "Card Holder", with: "Rodrigo Rato"
  fill_in "Card Number", with: "4556900772266350"
  first('.result').click_link("Confirm")
end

Then(/^I can see the reserved table in my reservations$/) do
  click_on "My Reservations"
  step("I can see the reservation details")
  within ".reservation-status" do
    expect(page).to have_content("Pending")
  end
end
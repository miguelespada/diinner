Given(/^There are some available tables$/) do
  @restaurant = FactoryGirl.create(:restaurant, :with_tables)
  @menu = @restaurant.menus.first
  @table = @restaurant.tables.first
end

When(/^I reserve a table$/) do
  step "I go to the user page"
  click_on "New reservation"
  select(20, :from => "reservation_price")
  fill_in "Date", with: @table.date.strftime('%d/%m/%Y')
  click_on "Search tables"

  within ".search-results" do
    step("I can see the table details")
  end
  
  click_on("Reserve")
  step("I fill in the credit card details")
  expect(page).to have_content("Table reserved succesfully!")
end

Then(/^I can see the table details$/) do
  expect(page).to have_content(@restaurant.name)
  expect(page).to have_content(@table.date)
  expect(page).to have_content(@table.hour)
  expect(page).to have_content(@menu.name)
  expect(page).to have_content(@menu.price)
  within ".affinity" do
    expect(page).to have_content("80%")
  end
end

Then(/^I fill in the credit card details$/) do
  fill_in "card_holder", with: "Rodrigo Rato"
  fill_in "card_number", with: "4556900772266350"
  
  check "terms_and_conditions"
  click_on "Confirm"
end


Then(/^I can see the reserved table in my reservations$/) do

  within ".reservations" do
    step("I can see the table details")
    within ".reservation-status" do
      expect(page).to have_content("Confirmed")
    end
  end
end
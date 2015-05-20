Given(/^There are some available tables$/) do
  step "I am logged as restaurant"
  step "I create a menu"
  step "I create a new table"
  
  @menu = @restaurant.menus.first
  @table = @restaurant.tables.first
  step "I logout"
end

When(/^I search a table$/) do
  step "I go to the user page"
  click_on "New reservation"
  select(20, :from => "reservation_price")
  fill_in "Date", with: @table.date.strftime('%Y-%m-%d')
  click_on "Search tables"
end

When(/^I reserve a table$/) do
  step("I search a table")

  within ".search-results" do
    step("I can see the table details")
  end
  
  click_on("Reserve")
  step("I fill in the credit card details")
  click_on "Confirm"
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
  fill_in "card_number", with: "4242424242424242"
  fill_in "exp_month", with: "12"
  fill_in "exp_year", with: "2020"
  fill_in "card_cvc", with: "975"
  find(:xpath, "//input[@id='stripe_card_token']").set "tok_164ZCaLxbPWgxCHRNkTEDWqc"
  check "terms_and_conditions"
end


Then(/^I can see the reserved table in my reservations$/) do
  within ".reservations" do
    step("I can see the table details")
    within ".reservation-status" do
      expect(page).to have_content("Confirmed")
    end
  end
end

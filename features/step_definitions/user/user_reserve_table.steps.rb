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
  # TODO move to support
  stripe_token = Stripe::Token.create({
      card: {
        name: "Rodrigo Rato",
        number: "4012888888881881",
        exp_month: '09',
        exp_year: '2020', 
        cvc: '123'
      }
    })

  fill_in "card_holder", with: "Rodrigo Rato"
  fill_in "card_number", with: "4012888888881881"
  fill_in "exp_month", with: "12"
  fill_in "exp_year", with: "2020"
  fill_in "card_cvc", with: "123"
  find(:xpath, "//input[@id='stripe_card_token']").set stripe_token.id
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

When(/^I cancel my reservation$/) do
  step "I go to the user page"
  click_on "My reservations"
  first(".reservation").click
  click_on "Cancel reservation"
end

Then(/^I do not see the reserved table in my reservations$/) do
  expect(page).to have_content("Reservation was successfully cancelled.")

  step "I go to the user page"
  click_on "My reservations"

  expect(page).not_to have_content(@restaurant.name)
  expect(page).not_to have_content(@table.date)
  expect(page).not_to have_content(@table.hour)
  expect(page).not_to have_content(@menu.name)
  expect(page).not_to have_content(@menu.price)
end

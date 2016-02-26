When(/^I go back$/) do
  find(".back").trigger("click")
end

Then(/^I can see I'm at the search form$/) do
  sleep(1)
  expect(page).to have_content("Buscar planes")
end

When(/^I search a table and go to payment$/) do
  step("I search a table with default values")
  click_on "reserve-#{@restaurant.name}"
end

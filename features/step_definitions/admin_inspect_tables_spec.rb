Given(/^a restaurant has created a table$/) do
  @restaurant = FactoryGirl.create(:restaurant)
  @table = @restaurant.tables.create
end

Then(/^I should see the table in the tables list$/) do
  click_on "Tables"
  expect(page).to have_content @restaurant.name
  expect(page).to have_content @table.id
  expect(page).to have_content @table.slots
end

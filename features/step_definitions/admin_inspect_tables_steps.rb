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
  @restaurant = FactoryGirl.create(:restaurant, :with_tables, tables_count: 5)
  @table = @restaurant.tables.first
  step "I go to the user page"
  find(".restaurants").click()
  click_on @restaurant.name
  click_on @table.id
  click_on "Reserve"
  step "I logout"
end

Then(/^I can see the reserved table$/) do
  click_on "Tables"
  click_on @table.name
  within('.users') do
    expect(page).to have_content @user.name
  end
end

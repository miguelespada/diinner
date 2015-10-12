Given(/^a restaurant has created a table$/) do
  @restaurant = FactoryGirl.create(:restaurant)
  @table = @restaurant.tables.create
  @table.menu =  FactoryGirl.create(:menu)
  @table.save! 
end

Then(/^I should see the table in the tables list$/) do
  click_on "Tables"
  expect(page).to have_content @restaurant.name
  expect(page).to have_content @table.locator
  expect(page).to have_content "3/3"
end


Given(/^A user has reserved a table$/) do
  step "I am a logged user"
  step "There are some available tables"
  step "I reserve a table"
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
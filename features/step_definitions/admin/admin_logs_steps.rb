When(/^a new user is registered$/) do
  first_time_user_login
end

Then(/^I should see the log of the creation of the new user$/) do
  click_on "Logs"
  within(:css, "#logs") do
    expect(page).to have_content "New user"
    expect(page).to have_content @first_time_user.name
  end
  # TODO add to shortlist
end

Then(/^I can access to the new user the data$/) do
  click_on @first_time_user.name
  expect(page).to have_content @first_time_user.email
end


When(/^a new restaurant is created$/) do
  @restaurant = FactoryGirl.create(:restaurant)
end

Then(/^I should see the log of the creation of the new restaurant$/) do
  click_on "Logs"
  within(:css, "#logs") do
    expect(page).to have_content "New restaurant"
    expect(page).to have_content @restaurant.name
  end
  # TODO add to shortlist
end

Then(/^I can access to the new restaurant the data$/) do
  click_on @restaurant.name
  expect(page).to have_content @restaurant.email
end

When(/^a user answers a test$/) do
  @user = FactoryGirl.create(:user, gender: "male")
  @test = FactoryGirl.create(:test, gender: "male")
  @test_response = TestResponse.create(response: @test.caption_A, user: @user, test: @test)
end

Then(/^I should see the log of the creation of the new test response$/) do
 click_on "Logs"
  within(:css, "#logs") do
    expect(page).to have_content "New test"
    expect(page).to have_content @test.caption_A
    expect(page).to have_content @user.name
  end
end

Then(/^I can access to the test response data$/) do
  click_on @test.question
  expect(page).to have_content @test.question
  expect(page).to have_content @user.name
end

Then(/^I should see the log of the creation of the new table$/) do
   click_on "Logs"
  within(:css, "#logs") do
    expect(page).to have_content "New table"
    expect(page).to have_content @restaurant.name
  end
end

Then(/^I can access to the table data$/) do
  click_on @table.id
  expect(page).to have_content @restaurant.name
  expect(page).to have_content @table.id
  expect(page).to have_content "3/3"
end

When(/^a restaurant has created a menu$/) do
  @restaurant = FactoryGirl.create(:restaurant)
  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @menu = @restaurant.menus.first
end

Then(/^I should see the log of the creation of the new menu$/) do
  click_on "Logs"
  within(:css, "#logs") do
    expect(page).to have_content "New menu"
    expect(page).to have_content @menu.name
    expect(page).to have_content @restaurant.name
  end
end

Then(/^I can access to the menu data$/) do
  click_on @menu.name
  expect(page).to have_content @restaurant.name
  within(".menu-price") do
    expect(page).to have_content @menu.price
  end
  expect(page).to have_content @menu.appetizer
  expect(page).to have_content @menu.main_dish
  expect(page).to have_content @dessert
  expect(page).to have_content @drink
end

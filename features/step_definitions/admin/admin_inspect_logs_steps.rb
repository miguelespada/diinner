When(/^a new user is registered$/) do
  first_time_user_login
  NotificationManager.notify_user_creation object: @first_time_user, from: @first_time_user
end

Then(/^I should see the log of the creation of the new user$/) do
  click_on "Logs"

  within(:css, "#logs") do
    expect(page).to have_content "New user"
    expect(page).to have_content @first_time_user.name
  end
end

Then(/^I can access to the new user the data$/) do
  within "#content" do
    click_on @first_time_user.name
  end
  expect(page).to have_content @first_time_user.email
end


Then(/^I should see the log of the creation of the new restaurant$/) do
  click_on "Logs"
  within(:css, "#logs") do
    expect(page).to have_content "New restaurant"
    expect(page).to have_content "dummy restaurant"
  end
end

Then(/^I can access to the new restaurant the data$/) do
  within "#content" do
    click_on "dummy restaurant"
  end
  expect(page).to have_content "restaurant@diinner.com"
end


Then(/^I should see the log of the creation of the new test response$/) do
   click_on "Logs"
   within(:css, "#logs") do
      expect(page).to have_content "New test"
      expect(page).to have_content @test.caption_A
      expect(page).to have_content @user.name
    end
end

When(/^a restaurant creates a table$/) do
   step "I am logged as restaurant"
   step "I create a new table having a menu"
end


Then(/^I should see the log of the creation of the new table$/) do
  click_on "Logs"
  within "#content" do
    within(:css, "#logs") do
      expect(page).to have_content "New table"
      expect(page).to have_content @restaurant.name
    end
  end
end

Then(/^I can access to the table data$/) do
  within "#content" do
    click_on Table.first.id
  end
  expect(page).to have_content @restaurant.name
  expect(page).to have_content "3/3"
end

When(/^a restaurant has created a menu$/) do
  step "I am logged as restaurant"
  step "I create a menu"
  @menu = Menu.first
end

Then(/^I should see the log of the creation of the new menu$/) do
  click_on "Logs"
  within "#content" do
    within(:css, "#logs") do
      expect(page).to have_content "New menu"
      expect(page).to have_content "Dummy menu"
      expect(page).to have_content @restaurant.name
    end
  end
end

Then(/^I can access to the menu data$/) do
  within "#content" do
    click_on "Dummy menu"
  end
  expect(page).to have_content @restaurant.name
  within(".menu-price") do
    expect(page).to have_content "20"
  end
  expect(page).to have_content "Dummy appetizer"
end

Then(/^I should see the log of the new reservation$/) do
  click_on "Logs"
  within("#logs .new-reservation-log") do
    expect(page).to have_content "New reservation"
    expect(page).to have_content @restaurant.name
    expect(page).to have_content @user.name
  end
end

When(/^a restaurant has created a menu and delete it$/) do
  step "a restaurant has created a menu"
  step "I delete a menu"
  step "I logout"
end

Then(/^I should not see the log of the creation of the new menu$/) do
  click_on "Logs"
  expect(page).not_to have_content "New menu"
end


When(/^I delete the test$/) do
  click_on  "Tests"
  click_on "Delete"
end

Then(/^I should not see the log of the creation of the new test response$/) do
  click_on "Logs"
  within(:css, "#logs") do
    expect(page).not_to have_content "New test"
  end
end


Then(/^I should not see the log of the evaluation$/) do
  click_on "Logs"
  expect(page).to have_content "New evaluation for restaurant restaurant_1"
end


Then(/^a restaurant deletes the table$/) do
  click_on "Delete"
end

Then(/^I should not see the log of the creation of the new table$/) do
  click_on "Logs"
  expect(page).not_to have_content "New table"
end


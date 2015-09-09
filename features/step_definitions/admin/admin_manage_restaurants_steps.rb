When(/^I create a new restaurant$/) do
  FactoryGirl.create(:city, name: "Madrid")
  FactoryGirl.create(:city, name: "Barcelona")
  visit admin_path
  click_on "Restaurants"
  click_on "New"
  fill_in "Email", with: "restaurant@diinner.com"
  fill_in "Name", with: "dummy restaurant"
  select "Madrid", :from => "restaurant_city_id"
  fill_in "Password", with: "12345678"
  click_button 'Create Restaurant'
end

Then(/^I should see the restaurant in the list of restaurants$/) do
  expect(page).to have_content "Restaurant was successfully created."
  within(:css, ".restaurant-email") do
    expect(page).to have_content "restaurant@diinner.com"
  end
  within(:css, ".restaurant-name") do
    expect(page).to have_content "restaurant"
  end
  within(:css, ".restaurant-status") do
    expect(page).to have_content "Last time active: never"
  end
end

Then(/^I should be notified that the restaurant is created$/) do
  click_on "Logs"
  expect(page).to have_content "New restaurant dummy restaurant created"
end

When(/^I delete a restaurant$/) do
  within(:css, ".restaurant-actions") do
    find(".delete").click
  end
end

Then(/^I should not see the restaurant in the list of restaurants$/) do
  expect(page).to have_content "Restaurant was successfully destroyed."
  expect(page).not_to have_content "restaurant@diinner.com"
end

When(/^I edit a restaurant$/) do
  within "#content" do
    click_on "dummy restaurant"
  end
  find(".edit").click
  fill_in "Name", with: "dummy restaurant updated"
  fill_in "Addres", with: "dummy address"
  fill_in "Phone", with: "666666"
  select "Barcelona", :from => "restaurant_city_id"
  click_button "Update Restaurant"
end

Then(/^I should see the updated restaurant in the list of restaurants$/) do

  expect(page).to have_content "Restaurant was successfully updated."
  within(:css, ".restaurant-name") do
    expect(page).to have_content "dummy restaurant updated"
  end
  within(:css, ".restaurant-address") do
    expect(page).to have_content "dummy address"
  end
  within(:css, ".restaurant-phone") do
    expect(page).to have_content "666666"
  end
  within(:css, ".restaurant-city") do
    expect(page).to have_content "Barcelona"
  end
end

Given(/^There are some reservations$/) do
  restaurant = Restaurant.first
  restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  restaurant.tables.create(FactoryGirl.build(:table, :for_today).attributes)
  table = restaurant.tables.first
  he = FactoryGirl.create(:user)
  FactoryGirl.create(:reservation, user: he, table: table, date: 2.days.ago)
end

Then(/^I cannot delete the restaurant$/) do
  expect(page).to have_content "This restaurant cannot be deleted."
  within(:css, ".restaurant-name") do
    expect(page).to have_content "dummy restaurant"
  end
end

Then(/^I should not see the restuarant notifications$/) do
  click_on "Logs"
  expect(page).not_to have_content "New restaurant dummy restaurant"
end

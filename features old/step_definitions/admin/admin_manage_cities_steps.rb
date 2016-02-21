When(/^I create a new city$/) do
  click_on "Cities"
  click_on "New"
  fill_in "Name", with: "Madrid"
  fill_in "Latitude", with: "4.222"
  fill_in "Longitude", with: "-0.0002"
  click_button 'Create City'
end

Then(/^I should see the city in the list of cities$/) do
  expect(page).to have_content "City was successfully created."
  click_on "Cities"
  within(:css, ".city-name") do
    expect(page).to have_content "Madrid"
  end
  within(:css, ".city-latitude") do
    expect(page).to have_content "4.222"
  end
  within(:css, ".city-longitude") do
    expect(page).to have_content "-0.0002"
  end

  click_on "Madrid"
  expect(page).to have_css ".admin-map"
  select "Madrid", :from => "city_city"
  expect(page).to have_css ".location"
end

When(/^I edit a city$/) do
  find(".edit").click
  fill_in "Name", with: "Barcelona"
  fill_in "Latitude", with: "4.223"
  fill_in "Longitude", with: "-0.0005"
  click_button "Update City"
end

Then(/^I should see the updated city in the list of cities$/) do
  within(:css, ".city-name") do
    expect(page).to have_content "Barcelona"
  end
  within(:css, ".city-latitude") do
    expect(page).to have_content "4.223"
  end
  within(:css, ".city-longitude") do
    expect(page).to have_content "-0.0005"
  end
end

When(/^I delete a city$/) do
  within(:css, ".city-actions") do
    find(".delete").click
  end
end

Then(/^I should not see the city in the list of cities$/) do
  click_on "Cities"
  expect(page).not_to have_content "Barcelona"
  expect(page).not_to have_content "4.223"
  expect(page).not_to have_content "-0.0005"
end

Given(/^There are some restaurants in the city$/) do
  city = City.first
  FactoryGirl.create(:restaurant, city: city)
end

When(/^I cannot delete the city$/) do
  expect(page).to have_content "This city cannot be deleted."
  within(:css, ".city-name") do
    expect(page).to have_content "Madrid"
  end
end
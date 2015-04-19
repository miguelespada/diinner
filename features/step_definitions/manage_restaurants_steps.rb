When(/^I create a new restaurant$/) do
  visit admin_path
  click_on "Restaurants"
  click_on "New"
  fill_in "Email", with: "restaurant@diinner.com"
  fill_in "Name", with: "dummy restaurant"
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

When(/^I delete a restaurant$/) do
  within(:css, ".restaurant-actions") do
    find(".delete").click
  end
end

Then(/^I should not see the restaurant in the list of restaurants$/) do
  expect(page).to have_content "Restaurant was successfully destroyed."
  expect(page).not_to have_content "restaurant@diinner.com"
end
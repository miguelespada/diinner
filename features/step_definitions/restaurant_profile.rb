When(/^I go to my profile page$/) do
  click_on "Profile"
end

Then(/^I should see my profile$/) do
  within(:css, ".restaurant-name") do
    expect(page).to have_content @restaurant.name
  end
end

When(/^I click to edit my profile$/) do
  step "I go to my profile page"
  click_on "Edit profile"
end

Then(/^I change my profile$/) do
  fill_in "Name", with: "Dummy restaurant"
  fill_in "Description", with: "Dummy description"
  fill_in "Phone", with: "12345678"
  fill_in "Address", with: "Dummy street 1"
  click_on "Update Restaurant"
end

Then(/^I should see my profile has been updated$/) do
  within(:css, ".restaurant-name") do
    expect(page).to have_content "Dummy restaurant"
  end

  within(:css, ".restaurant-description") do
    expect(page).to have_content "Dummy description"
  end

  within(:css, ".restaurant-phone") do
    expect(page).to have_content "12345678"
  end

  within(:css, ".restaurant-address") do
    expect(page).to have_content "Dummy street 1"
  end
end

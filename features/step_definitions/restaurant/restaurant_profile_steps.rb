When(/^I go to my profile page$/) do
  find(".show").click()
end

Then(/^I should see my profile$/) do
  within(:css, ".restaurant-name") do
    expect(page).to have_content @restaurant.name
  end
end

Then(/^I edit my restaurant profile$/) do
  find(".edit").click()
  fill_in "Name", with: "Dummy restaurant"
  fill_in "Description", with: "Dummy description"
  fill_in "Phone", with: "12345678"
  fill_in "Address", with: "Dummy street 1"
  fill_in "Contact person", with: "Dummy Jaime"
  click_on "Update Restaurant"
end

Then(/^I should see my restaurant profile updated$/) do
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

  within(:css, ".restaurant-contact-person") do
    expect(page).to have_content "Dummy Jaime"
  end
end

When(/^I edit my restaurant password$/) do
  click_on "Change password"
  fill_in "Current password", with: @restaurant.password
  fill_in "Password", with: "updated1111"
  fill_in "Password confirmation", with: "updated1111"
  click_on "Update password"
  expect(page).to have_content "Your password was successfully updated."
end

When(/^I change my restaurant password$/) do
  fill_in "Current password", with: @restaurant.password
  fill_in "Password", with: "updated1111"
  fill_in "Password confirmation", with: "updated1111"
  click_on "Update password"
end

Then(/^I should check my password has changed$/) do
  expect(page).to have_content "Your password was successfully updated."
  step "I logout"
  click_on "Restaurant"
  fill_in "Email", with: @restaurant.email
  fill_in "Password", with: "updated1111"
  click_on "Log in"
  step "I should see my profile"
end

Given(/^I login as restaurant with first password$/) do
  first_password_restaurant_login
end
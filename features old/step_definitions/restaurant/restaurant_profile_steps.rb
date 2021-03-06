When(/^I go to my profile page$/) do
  click_on "Profile"
end

Then(/^I should see my profile$/) do
  within(:css, ".restaurant-name") do
    expect(page).to have_content @restaurant.name
  end
end

Then(/^I edit my restaurant profile$/) do
  step "I go to my profile page"
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

When(/^I change my restaurant password$/) do
  step "I go to my profile page"
  within(".custom-alert-warning") do
    click_on "Change password"
  end
  fill_in "Current password", with: @restaurant.password
  fill_in "Password", with: "updated1111"
  fill_in "Password confirmation", with: "updated1111"
  click_on "Update"
end


Then(/^I should check my password has changed$/) do
  click_on "¿Eres un restaurante?"
  step "I logout"
  click_on "¿Eres un restaurante?"
  fill_in "Email", with: @restaurant.email
  fill_in "Password", with: "updated1111"
  click_button 'Log in'
  expect(page).to have_content @restaurant.name
  expect(page).not_to have_content "For security reasons, you should change your password."
end

Then(/^I should see that a suggestion to change my password$/) do
  expect(page).to have_content "For security reasons, you should change your password."
end
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

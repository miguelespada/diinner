Then(/^I should see the menu in the menu list$/) do
  click_on "Menus"
  expect(page).to have_content @menu.name
  expect(page).to have_content @menu.price
  expect(page).to have_content @menu.restaurant.name
end

Then(/^I should see the menu in the restaurant data$/) do
  click_on "Restaurants"
  within "#content" do
    click_on @restaurant.name
  end
  within(".menus") do
    expect(page).to have_content @menu.name
    expect(page).to have_content @menu.price
  end
  
end


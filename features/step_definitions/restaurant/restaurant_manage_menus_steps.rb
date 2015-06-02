When(/^I create a menu$/) do
  click_on "Menus"
  click_on "New"
  fill_in "Name", with: "Dummy menu"
  fill_in "Description", with: "Dummy description"
  select "20", from: "Price"
  fill_in "Appetizer", with: "Dummy appetizer"
  fill_in "Main dish", with: "Dummy dish"
  fill_in "Dessert", with: "Dummy dessert"
  fill_in "Drink", with: "Dummy drink"
  click_on "Create Menu"
end

When(/^I create a menu 60$/) do
  click_on "Menus"
  click_on "New"
  fill_in "Name", with: "Dummy menu 60"
  fill_in "Description", with: "Dummy description"
  select "60", from: "Price"
  fill_in "Appetizer", with: "Dummy appetizer"
  fill_in "Main dish", with: "Dummy dish"
  fill_in "Dessert", with: "Dummy dessert"
  fill_in "Drink", with: "Dummy drink"
  click_on "Create Menu"
end

When(/^I create a menu 40$/) do
  click_on "Menus"
  click_on "New"
  fill_in "Name", with: "Dummy menu 40"
  fill_in "Description", with: "Dummy description"
  select "40", from: "Price"
  fill_in "Appetizer", with: "Dummy appetizer"
  fill_in "Main dish", with: "Dummy dish"
  fill_in "Dessert", with: "Dummy dessert"
  fill_in "Drink", with: "Dummy drink"
  click_on "Create Menu"
end

Then(/^I should see the menu in the list of my menus$/) do
  expect(page).to have_content "Menu was successfully created."
  within(:css, ".menu-name") do
    expect(page).to have_content "Dummy menu"
  end
  within(:css, ".menu-price") do
    expect(page).to have_content "20"
  end
  within(:css, ".menu-description") do
    expect(page).to have_content "Dummy description"
  end
  within(:css, ".menu-appetizer") do
    expect(page).to have_content "Dummy appetizer"
  end
  within(:css, ".menu-main-dish") do
    expect(page).to have_content "Dummy dish"
  end
  within(:css, ".menu-dessert") do
    expect(page).to have_content "Dummy dessert"
  end
  within(:css, ".menu-drink") do
    expect(page).to have_content "Dummy drink"
  end
end

When(/^I edit a menu$/) do
  within(:css, ".menu-actions") do
    find(".edit").click
  end
  fill_in "Name", with: "New dummy menu"
  click_on "Update Menu"
end

Then(/^I should see the menu updated$/) do
  within(:css, ".menu-name") do
    expect(page).to have_content "New dummy menu"
  end
end

When(/^I delete a menu$/) do
  within(:css, ".menu-actions") do
    find(".delete").click
  end
end

Then(/^I should not see the menu in the list of my menus$/) do
  expect(page).to have_content "Menu was successfully destroyed."
  expect(page).not_to have_content "Dummy menu"
end

Then(/^I cant edit the reserved menu$/) do
  click_on "Menus"
  within(:css, ".menu-actions") do
    find(".edit").click
  end
  expect(page).to have_content "This menu has users."
end

Then(/^I cant delete the reserved menu$/) do
  click_on "Menus"
  within(:css, ".menu-actions") do
    find(".delete").click
  end
  expect(page).to have_content "This menu has users."
end

Then(/^I cant edit the reserved table$/) do
  click_on "Tables"
  within(:css, ".table-actions") do
    find(".edit").click
  end
  expect(page).to have_content "This table has users."
end

Then(/^I cant delete the reserved table$/) do
  click_on "Tables"
  within(:css, ".table-actions") do
    find(".delete").click
  end
  expect(page).to have_content "This table has users."
end
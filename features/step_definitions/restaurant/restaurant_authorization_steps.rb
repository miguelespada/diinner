When(/^I visit other restaurant data$/) do
  @other = FactoryGirl.create(:restaurant)
  visit restaurant_path(@other)
end

Then(/^I do not see the edit link$/) do
  expect(page).not_to have_css ".edit"
end

When(/^I try to edit the other restaurant data$/) do
  visit edit_restaurant_path(@other)
end

Then(/^I receive an unauthorized exception$/) do
  expect(page).to have_content "The change you wanted was rejected."
end

Then(/^I cannot access other restaurant menu$/) do
  @menu = FactoryGirl.build(:menu, name: "Other menu")
  @other.menus.create(@menu.attributes)
  visit restaurant_menu_path(@other, @other.menus.first)
  expect(page).to have_content "The change you wanted was rejected."
end
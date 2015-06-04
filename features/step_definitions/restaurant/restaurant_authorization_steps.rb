When(/^I visit other restaurant data$/) do
  @other = FactoryGirl.create(:restaurant)
  @other.menus.create(FactoryGirl.build(:menu).attributes)
  @other.tables.create(FactoryGirl.build(:table).attributes)

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
  visit restaurant_menu_path(@other, @other.menus.first)
  expect(page).to have_content "The change you wanted was rejected."
end

Then(/^I cannot access other restaurant table$/) do
  visit restaurant_table_path(@other, @other.tables.first)
  expect(page).to have_content "The change you wanted was rejected."
end
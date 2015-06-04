When(/^There is another restaurant$/) do
  @other = FactoryGirl.create(:restaurant)
  @other.menus.create(FactoryGirl.build(:menu).attributes)
  @other.tables.create(FactoryGirl.build(:table).attributes)
  @user = FactoryGirl.create(:user)
  FactoryGirl.create(:reservation, user: @user, table: @other.tables.first)
end

Then(/^I cannot access other restaurant data$/) do
  visit edit_restaurant_path(@other)
  expect(page).to have_content "The change you wanted was rejected."
end

Then(/^I cannot access other restaurant menus$/) do
  visit restaurant_menu_path(@other, @other.menus.first)
  expect(page).to have_content "The change you wanted was rejected."
end

Then(/^I cannot access other restaurant tables$/) do
  visit restaurant_table_path(@other, @other.tables.first)
  expect(page).to have_content "The change you wanted was rejected."
end

Then(/^I cannot access other restaurant reservations$/) do
  visit restaurant_reservations_path(@other, @other.reservations.first)
  expect(page).to have_content "The change you wanted was rejected."
end
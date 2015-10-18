Given(/^There are some tables$/) do
  city = FactoryGirl.create(:city)
  restaurant = FactoryGirl.create(:restaurant, city: city)
  restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  restaurant.tables.create(FactoryGirl.build(:table, :for_yesterday).attributes)
  restaurant.tables.create(FactoryGirl.build(:table, :for_today).attributes)
  restaurant.tables.create(FactoryGirl.build(:table, :for_tomorrow).attributes)

  he = FactoryGirl.create(:user)
end

When(/^I batch delete the tables$/) do
  find(".settings").click
  click_on "Remove old tables"
end

Then(/^I should not see the old tables$/) do
  expect(page).to have_content "1 table(s) removed!"
end
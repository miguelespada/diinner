Given(/^There are some last minute diinners$/) do
  city = FactoryGirl.create(:city)
  @restaurant = FactoryGirl.create(:restaurant, city: city)
  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @restaurant.tables.create(FactoryGirl.build(:table, :for_today).attributes)
  @menu = @restaurant.menus.first
  @table = @restaurant.tables.first

  he = FactoryGirl.create(:user, gender: :male)
  she = FactoryGirl.create(:user, gender: :female)

  FactoryGirl.create(:reservation, user: he, table: @table)
  FactoryGirl.create(:reservation, user: he, table: @table)
  FactoryGirl.create(:reservation, user: she, table: @table)
  FactoryGirl.create(:reservation, user: she, table: @table)

end

When(/^I reserve a last minute diinner$/) do
  click_on "Last minute diinners"
end

When(/^Another user reserves a last minute diinner$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I shoud be notified that my plan is confirmed$/) do
  pending # express the regexp above with the code you wish you had
end
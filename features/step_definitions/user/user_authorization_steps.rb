When(/^There is another user$/) do
  @other = FactoryGirl.create(:user)
  @restaurant = FactoryGirl.create(:restaurant)
  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @restaurant.tables.create(FactoryGirl.build(:table).attributes)
  @reservation = FactoryGirl.create(:reservation, user: @user, table: @restaurant.tables.first)
  @test = FactoryGirl.create(:test)
end


Then(/^I cannot access other user data$/) do
  visit user_path(@other)
  expect(page).to have_content "The change you wanted was rejected."
  visit edit_user_path(@other)
  expect(page).to have_content "The change you wanted was rejected."
  visit user_reservations_path(@other)
  expect(page).to have_content "The change you wanted was rejected."
  visit user_reservations_path(@other)
  expect(page).to have_content "The change you wanted was rejected."
  visit user_reservation_path(@other, @reservation)
  expect(page).to have_content "The change you wanted was rejected."
end
Given(/^I have some notifications$/) do
  restaurant = FactoryGirl.create(:restaurant, :with_tables)
  table = restaurant.tables.first
  reservation = FactoryGirl.create(:reservation, table: table, user: @user)
  reservation.notify_plan "confirmed"
end

When(/^I delete a notification$/) do
  click_on "Notifications"
  within("#logs") do
    expect(page).to have_content "Your plan diinner for tonight at restaurant"
    click_on "delete"
  end
  expect(page).to have_content 'Activity were successfully destroyed.'
end

Then(/^I do not see the notification$/) do
  click_on "Notifications"
  within("#logs") do
    expect(page).not_to have_content "Your plan diinner for tonight at restaurant"
  end
end
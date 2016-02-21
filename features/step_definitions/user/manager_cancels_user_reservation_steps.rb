Given(/^I will expect a plan cancellation notification$/) do
  expect(EmailNotifications).to receive(:notify_plan_cancellation).exactly(1).times
end

When(/^the table manager process runs$/) do
  allow(Date).to receive(:today).and_return Date.tomorrow
  TableManager.process_today_tables
end

Then(/^I can see the cancellation notification$/) do

  visit @user_path
  click_on "Notificaciones"

  expect(page).to have_content("Lo sentimos. Tu plan en el restaurante #{@restaurant.name}")
  expect(page).to have_content("ha sido cancelado") 

  find(".notification-list a").click
  expect(page).to have_content("El estado del plan es CANCELADO")

end
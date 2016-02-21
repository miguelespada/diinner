Given(/^I will expect a evaluation notification$/) do
  expect(EmailNotifications).to receive(:invite_to_evaluate).exactly(3).times
end


When(/^I had a plan$/) do
  step "There are some available tables for tomorrow"
  step "There is a plan closed for tomorrow"
  step "I make a reservation"
  step "the table manager process runs"
end

When(/^The diinner has passed$/) do
  allow(Date).to receive(:yesterday).and_return (@table.date)
  allow(Date).to receive(:today).and_return (@table.date + 1.day)
  Reservation.invite_to_evaluate
end

Then(/^I evaluate the plan$/) do
  visit @user_path
  click_on "Notificaciones"
  expect(page).to have_content "Puedes evaluar tu plan diinner en el restaurante #{@restaurant.name}"
  click_on "Mis reservas"
  find(".has-events > a").click
  click_on "Evaluar"
  fill_in :evaluation_comments, with: "The food was great"
  select 5, from: :evaluation_quality_of_menu
  select 3, from: :evaluation_quality_of_restaurant
  check :evaluation_had_fun
  click_on "Evaluar"
  expect(page).to have_content "Gracias por tu evaluación"

  click_on "Mis reservas"
  find(".has-events > a").click
  expect(page).not_to have_content "Evaluar"
  visit @user_path
  expect(page).not_to have_content "Evaluar"
end

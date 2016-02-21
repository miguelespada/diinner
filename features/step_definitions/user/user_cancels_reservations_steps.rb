Then(/^I make a reservation$/) do
  FactoryGirl.create(:reservation, user: @user, table: @table, date: @table.date)
end

When(/^I cancel my reservation$/) do
  step "I go to the user page"
  find("#reservation-#{@restaurant.name}").click
  click_on "Cancel"
  expect(page).to have_content("No tienes reservas")

  click_on "Mis reservas"
  expect(page).to have_css ".calendar"
  expect(page).not_to have_css ".has-events"
end

Then(/^I can see the notification that the reservation is cancelled$/) do
  click_on "Notificaciones"
  expect(page).to have_content("La reserva para el restaurante #{@restaurant.name}")
  expect(page).to have_content("se ha cancelado correctamente.") 
end

Then(/^I should not see the reserved table$/) do
  click_on "Mis reservas"
  expect(page).to have_css ".calendar"
  expect(page).not_to have_css ".has-events"
end

Then(/^I have previous cancelled reservations$/) do
  step("There are some available tables for tomorrow")
  expect(EmailNotifications).to receive(:notify_cancel_reservation).exactly(2).times

  @user.update_customer_information!(Stripe::Token.create(valid_card).id)  
  FactoryGirl.create(:reservation, user: @user, table: @table, date: @table.date)

  expect(@user.reservations.count).to eq 1
  expect(@user.reservations.first.can_be_cancelled?).to eq true

  visit user_path(@user)
  
  click_on "Mis reservas"
  expect(page).to have_css ".calendar"
  within ".has-events" do
    expect(page).to have_content(@table.hour.strftime("%H:%M"))
    find("a").click
  end
  expect(page).to have_content("El estado del plan es RESERVADO")

  step("I cancel my reservation")
end
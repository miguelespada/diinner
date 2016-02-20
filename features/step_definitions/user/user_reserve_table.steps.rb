Given(/^There are some available tables$/) do

  # We mock the following steps
    # step "I am logged as restaurant"
    # step "I create a menu"
    # step "I create a new table"
    # step "I logout"

  city = FactoryGirl.create(:city)
  @restaurant = FactoryGirl.create(:restaurant, city: city)
  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @menu = @restaurant.menus.first
  @restaurant.tables.create(FactoryGirl.build(:table, menu: @menu).attributes)
  @table = @restaurant.tables.first
  @table.date = Date.tomorrow
end

Then(/^I had previous cancelled reservations$/) do

  expect(EmailNotifications).to receive(:notify_cancel_reservation).at_least(:once)

  @user.update_customer_information!(Stripe::Token.create(valid_card).id)
  
  FactoryGirl.create(:reservation, user: @user, table: @table, date: @table.date)
  expect(@user.reservations.count).to eq 1
  expect(@user.reservations.first.can_be_cancelled?).to eq true
  step("I cancel my reservation")
end


Then(/^I made a reservation$/) do
  step("I had previous cancelled reservations")

  FactoryGirl.create(:reservation, user: @user, table: @table, date: @table.date)
  expect(@user.reservations.count).to eq 2
  expect(@user.reservations.first.can_be_cancelled?).to eq false
  expect(@user.reservations.last.can_be_cancelled?).to eq true

end

When(/^I search a table with bad date$/) do
  step "I go to the user page"
  click_on "New Reservation", match: :first
  select("Lowcost", :from => "reservation_price")
  find("#reservation_date", visible: false).set Date.today
  select "Madrid", :from => "reservation_city"
  click_on "Search tables"
end

When(/^I shoud be notified that my date is out of range$/) do
  expect(page).to have_content("You can only reserve Diiners from tomorrow within two weeks")
end


When(/^I search a table$/) do
  expect(@user.reservations.count).to eq 0
  step "I go to the user page"
  find("#new-reservation-link").trigger("click")
  # select("Lowcost", :from => "reservation_price")
  # find("#reservation_date", visible: false).set @table.date.to_date
  # select "Madrid", :from => "reservation_city"
  click_on "Buscar mesas"
end

When(/^I reserve a table$/) do
  step("I search a table")
  # within ".search-results" do
  #   step("I can see the table details")
  # end

  click_on "reserve-#{@restaurant.name}"
  step("I fill in the credit card details")
  find("#continuar").trigger("click")

end

Then(/^I see the confirmation$/) do
  # expect(page).to have_content("Tu reserva se ha realizado correctamente")
  
  expect(page).to have_content("El estado del plan es RESERVADO")
  expect(@user.reservations.count).to eq 1
  expect(@user.reservations.first.cancelled?).to eq false
  expect(@user.reservations.first.is_last_minute?).to eq false
end


Then(/^I can see the table details$/) do

  expect(page).to have_content(@restaurant.name.upcase)
  
  # expect(page).to have_content(@table.date)
  expect(page).to have_content(@table.hour.strftime("%H:%M"))
  expect(page).to have_content(@menu.name)
  expect(page).to have_content(@menu.price)

  expect(page).to have_content("#{@table.affinity}%")
end

Then(/^I fill in the credit card details$/) do
  fill_in "card_holder", with: "Rodrigo Rato"
  fill_in "card_number", with: "4012888888881881"
  fill_in "exp_month", with: "12"
  fill_in "exp_year", with: "2020"
  fill_in "card_cvc", with: "123"
  # find(:xpath, "//input[@id='stripe_card_token']").set "Dummy_token"
  allow_any_instance_of(User).to receive(:get_stripe_create_customer!).and_return(Stripe::Customer.new(id: "123"))
  allow_any_instance_of(User).to receive(:get_stripe_default_card!).and_return("1881")

end


Then(/^I can see the reserved table in my reservations$/) do
  find(".status-table > a").click
  step("I can see the table details")
  within ".reservation-status" do
    expect(page).to have_content("Pending")
  end
end

Then(/^I can see the reserved table in my calendar$/) do
  click_on "My reservations"
  expect(page).to have_css ".calendar"
  within ".has-events" do
    expect(page).to have_content(@table.hour.strftime("%H:%M"))
  end
end

When(/^I cancel my reservation$/) do
  step "I go to the user page"
  save_and_open_page
  find("#reservation-#{@restaurant.name}").click
  click_on "Cancel"
  expect(page).to have_content("No tienes reservas")
end

Then(/^I can see the notification that the reservation is cancelled$/) do
  click_on "Notificaciones"
  expect(@user.notifications.count).to be 2

  expect(page).to have_content("La reserva para el restaurante restaurant_1")
  expect(page).to have_content("se ha cancelado correcamente.")
end

Then(/^I should not see the reserved table in my calendar$/) do
  click_on "My reservations"
  expect(page).to have_css ".calendar"
  expect(page).not_to have_css ".has-events"
end

Then(/^I can access restaurant data$/) do
  click_on "My reservations"
  click_on @user.reservations.first.hour.strftime("%H:%M")

  expect(page).to have_content @restaurant.name
  expect(page).to have_content @restaurant.city.name
end

Then(/^I can access menu data$/) do
  step "I go to the user page"
  click_on "My reservations"
  click_on @user.reservations.first.hour.strftime("%H:%M")
  expect(page).to have_content @menu.main_dish
  expect(page).to have_content @menu.price
  expect(page).to have_content @menu.appetizer
end

Then(/^I can see my default card on my profile$/) do
  click_on "My profile"
  expect(page).to have_content "DEFAULT CARD"
  expect(page).to have_content "**** **** **** 1881"
end

Then(/^I can reserve again with the same card$/) do
  step("I cancel my reservation")
  step("I search a table")
  click_on(@restaurant.name)
  click_on "Use saved card"
  expect(page).to have_content("Table reserved succesfully!")
end

When(/^the table manager process runs$/) do
  allow(Date).to receive(:today).and_return Date.tomorrow

  TableManager.process_today_tables
end

Then(/^I can see the cancellation notification$/) do
  expect(@user.notifications.count).to eq 1
  expect(@user.has_notifications?).to eq true
  visit user_path(@user)

  click_on "Notificaciones"
  expect(page).to have_content "Lo sentimos. Tu plan en el restaurante restaurant_1"
  expect(page).to have_content "ha sido cancelado"

end

Given(/^There are enough reservations$/) do
    @he = FactoryGirl.create(:user, gender: :male)
    @she = FactoryGirl.create(:user, gender: :female)

    return_value = Hash.new
    return_value[:id] = "123"
    allow_any_instance_of(Reservation).to receive(:create_stripe_charge).and_return return_value
    allow_any_instance_of(Reservation).to receive(:stripe_capture).and_return return_value
    allow_any_instance_of(Reservation).to receive(:stripe_refund).and_return return_value

    FactoryGirl.create(:reservation, user: @he, table: @table)
    FactoryGirl.create(:reservation, user: @he, table: @table)
    FactoryGirl.create(:reservation, user: @she, table: @table)
    FactoryGirl.create(:reservation, user: @she, table: @table)
end

Then(/^I can see the plan confirmation notification$/) do
  click_on "Notifications"
  within("#logs .plan-confirmed-log") do
    expect(page).to have_content "Your plan diinner for tonight at restaurant #{@table.restaurant.name} is confirmed!!!"
  end
end

Then(/^I can see the reservation notification$/) do
  click_on "Notifications"
  within("#logs .plan-pending-log") do
    expect(page).to have_content "Your plan diinner for tonight at restaurant #{@table.restaurant.name} is waiting for confirmation!!!"
  end
end

Then(/^I cannot reserve a table the same date$/) do
  step "I search a table"
  expect(page).to have_content "You already have a reservation for this date"
end


When(/^Is the reservation day$/) do
  @reservation = @user.reservations.last
  @reservation.update(date: Date.today)
  @reservation.table.update(date: Date.today)
end

When(/^The reservation has not been processed$/) do
  @reservation.table.processed = false
end

Then(/^I can't see the reservation$/) do
  visit user_path(@user)
  expect(page).not_to have_content @reservation.restaurant.name
  visit user_reservation_path(@user, @reservation)
  expect(page).to have_content "Pulsa en reservar para buscar planes diinner" #todo notification instead of user profile text
end

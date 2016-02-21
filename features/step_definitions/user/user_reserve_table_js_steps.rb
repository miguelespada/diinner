Given(/^There are some available tables for tomorrow$/) do
  city = FactoryGirl.create(:city)
  @restaurant = FactoryGirl.create(:restaurant, city: city)
  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @menu = @restaurant.menus.first
  @restaurant.tables.create(FactoryGirl.build(:table, menu: @menu, date: Date.tomorrow).attributes)
  @table = @restaurant.tables.first
end

When(/^I reserve a table for tomorrow$/) do

  expect(EmailNotifications).to receive(:notify_new_reservation).exactly(1).times
  step("I search a table with default values")

  within ".search-results" do
    expect(page).to have_content(@restaurant.name)
    expect(page).to have_content(@menu.name)
    expect(page).to have_content(@menu.price)
  end

  click_on "reserve-#{@restaurant.name}"
  step("I fill in the credit card with valid details")
  find("#continuar").trigger("click")
end

When(/^I search a table with default values$/) do
  step "I go to the user page"
  find("#new-reservation-link").trigger("click")
  click_on "Buscar mesas"
end

Then(/^I fill in the credit card with valid details$/) do
  fill_in "card_holder", with: "Rodrigo Rato"
  fill_in "card_number", with: "4012888888881881"
  fill_in "exp_month", with: "12"
  fill_in "exp_year", with: "2020"
  fill_in "card_cvc", with: "123"
  allow_any_instance_of(User).to receive(:get_stripe_create_customer!).and_return(Stripe::Customer.new(id: "123"))
  allow_any_instance_of(User).to receive(:get_stripe_default_card!).and_return("1881")
end

Then(/^I see the table details$/) do
  sleep(1)
  expect(page).to have_content("El estado del plan es RESERVADO")
  expect(@user.reservations.count).to eq 1
  expect(@user.notifications.count).to eq 1
  expect(@user.reservations.first.cancelled?).to eq false
  expect(@user.reservations.first.is_last_minute?).to eq false
  click_on "Notificaciones"
  expect(page).to have_content("Tu plan diinner en el restaurante #{@restaurant.name} el día #{@table.date} se ha reservado correctamente.") 
end
Given(/^There are some available tables for tomorrow$/) do
  city = FactoryGirl.create(:city)
  @restaurant = FactoryGirl.create(:restaurant, city: city)
  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @menu = @restaurant.menus.first
  @restaurant.tables.create(FactoryGirl.build(:table, menu: @menu, date: Date.tomorrow).attributes)
  @table = @restaurant.tables.first
end

Given(/^There are some available tables for any day$/) do
  city = FactoryGirl.create(:city)
  @restaurant = FactoryGirl.create(:restaurant, city: city)
  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @menu = @restaurant.menus.first
  @restaurant.tables.create(FactoryGirl.build(:table, menu: @menu, date: Date.tomorrow + 1.day).attributes)
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

Given(/^There is a full table for tomorrow$/) do
  city = FactoryGirl.create(:city)
  @restaurant = FactoryGirl.create(:restaurant, city: city)
  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @menu = @restaurant.menus.first
  @restaurant.tables.create(FactoryGirl.build(:table, menu: @menu, date: Date.tomorrow).attributes)
  @table = @restaurant.tables.first
  he = FactoryGirl.create(:user, :with_customer_id,  gender: :male)
  she = FactoryGirl.create(:user, :with_customer_id,  gender: :female)
  FactoryGirl.create(:reservation, user: he, table: @table, date: @table.date, customer: "123")
  FactoryGirl.create(:reservation, user: he, table: @table, date: @table.date, customer: "456")
  FactoryGirl.create(:reservation, user: she, table: @table, date: @table.date, customer: "243")
  FactoryGirl.create(:reservation, user: she, table: @table, date:@table.date, customer: "987")
  FactoryGirl.create(:reservation, user: he, table: @table, date: @table.date, customer: "111")
  FactoryGirl.create(:reservation, user: she, table: @table, date: @table.date, customer: "222")
end

Then(/^I should see I can't reserve the full table$/) do

  expect(EmailNotifications).to receive(:notify_new_reservation).exactly(0).times
  step("I search a table with default values")

  expect(page).not_to have_content(@restaurant.name)
  expect(page).not_to have_content(@menu.name)
  expect(page).not_to have_content(@menu.price)

  expect(page).to have_content("Lo sentimos, no hay mesas para la búsqueda que has realizado")
end

When(/^I should see I can't reserve any more tables$/) do

  expect(EmailNotifications).to receive(:notify_new_reservation).exactly(0).times
  step("I search a table with default values")
  expect(page).to have_content("Ya tienes una reserva para esa fecha")
end

And(/^I have reserved a table$/) do
  step("I reserve a table for tomorrow")
  step("I see the table details")
end

When(/^I reserve a table for tomorrow with payment errors$/) do

  expect(EmailNotifications).to receive(:notify_new_reservation).exactly(0).times
  step("I search a table with default values")

  within ".search-results" do
    expect(page).to have_content(@restaurant.name)
    expect(page).to have_content(@menu.name)
    expect(page).to have_content(@menu.price)
  end

  click_on "reserve-#{@restaurant.name}"
  step("I fill in the credit card with invalid details")
  find("#continuar").trigger("click")
end

When(/^I reserve a table for tomorrow with company 1$/) do

  expect(EmailNotifications).to receive(:notify_new_reservation).exactly(1).times
  step("I search a table with company 1")
  within ".search-results" do
    expect(page).to have_content(@restaurant.name)
    expect(page).to have_content(@menu.name)
    expect(page).to have_content(@menu.price)
    expect(page).to have_content(@menu.price * 2)
  end

  click_on "reserve-#{@restaurant.name}"
  step("I fill in the credit card with valid details")
  expect(page).to have_content("Número de menús: 2")
  find("#continuar").trigger("click")
end

When(/^I reserve a table for tomorrow with company 2$/) do

  expect(EmailNotifications).to receive(:notify_new_reservation).exactly(1).times
  step("I search a table with company 2")
  within ".search-results" do
    expect(page).to have_content(@restaurant.name)
    expect(page).to have_content(@menu.name)
    expect(page).to have_content(@menu.price)
    expect(page).to have_content(@menu.price * 3)
  end

  click_on "reserve-#{@restaurant.name}"
  step("I fill in the credit card with valid details")
  expect(page).to have_content("Número de menús: 3")
  find("#continuar").trigger("click")
end

When(/^I reserve a table for any day$/) do

  expect(EmailNotifications).to receive(:notify_new_reservation).exactly(1).times
  step("I search a table for any day")

  within ".search-results" do
    expect(page).to have_content(@restaurant.name)
    expect(page).to have_content(@menu.name)
    expect(page).to have_content(@menu.price)
  end

  click_on "reserve-#{@restaurant.name}"
  step("I fill in the credit card with valid details")
  find("#continuar").trigger("click")
end

When(/^I search a table for any day$/) do
  step "I go to the user page"
  find("#new-reservation-link").trigger("click")
  find(".last.day-toggle").trigger("click")
  click_on "Buscar mesas"
end

When(/^I search a table with default values$/) do
  step "I go to the user page"
  find("#new-reservation-link").trigger("click")
  click_on "Buscar mesas"
end

When(/^I search a table with company 1$/) do
  step "I go to the user page"
  find("#new-reservation-link").trigger("click")
  find(".company-toggle[data-company='1']").trigger("click")
  find(".toggle[data-number='1']").trigger("click")
  within "#friend_0" do
    find(".friend-toggle[data-gender='male']").trigger("click")
    fill_in "Edad", with: "30"
  end
  click_on "Buscar mesas"
end

When(/^I search a table with company 2$/) do
  step "I go to the user page"
  find("#new-reservation-link").trigger("click")
  find(".company-toggle[data-company='1']").trigger("click")
  find(".toggle[data-number='2']").trigger("click")
  within "#friend_0" do
    find(".friend-toggle[data-gender='male']").trigger("click")
    fill_in "Edad", with: "30"
  end
  within "#friend_1" do
    find(".friend-toggle[data-gender='female']").trigger("click")
    fill_in "Edad", with: "27"
  end
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
  allow_any_instance_of(Reservation).to receive(:get_stripe_create_customer!).and_return(Stripe::Customer.new(id: "123"))
  allow_any_instance_of(Reservation).to receive(:get_stripe_default_card!).and_return("1881")
end

Then(/^I fill in the credit card with invalid details$/) do
  step "I fill in the credit card with valid details"
  fill_in "exp_year", with: "2001"
end

Then(/^I can see the table has been reserved/) do
  expect(page).to have_content("El estado del plan es RESERVADO")
  expect(@user.reservations.count).to eq 1
  expect(@user.notifications.count).to eq 1
  expect(@user.reservations.first.cancelled?).to eq false
  expect(@user.reservations.first.is_last_minute?).to eq false
end

Then(/^I can see reservation notification/) do
  click_on "Notificaciones"
  expect(page).to have_content("Tu plan diinner en el restaurante #{@restaurant.name} el día #{@table.date} se ha reservado correctamente.")
end

Then(/^I sleep JS$/) do
  sleep(1)
end


Then(/^I see the table details$/) do
  step "I sleep JS"
  step "I can see the table has been reserved"
  step "I can see reservation notification"
end

Then(/^I see the table details with company 1$/) do
  step "I sleep JS"
  expect(page).to have_content("Número de menús comprados: 2")
  step "I can see the table has been reserved"
  step "I can see reservation notification"
end

Then(/^I see the table details with company 2$/) do
  step "I sleep JS"
  expect(page).to have_content("Número de menús comprados: 3")
  step "I can see the table has been reserved"
  step "I can see reservation notification"
end

Then(/^I see there is an error with the payment$/) do
  step "I sleep JS"
  expect(page).to have_content("El año de caducidad de la tarjeta no es válido.")
end
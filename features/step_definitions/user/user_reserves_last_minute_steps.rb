Given(/^There is a last minute plan for today$/) do
  @city = FactoryGirl.create(:city)

  @restaurant = FactoryGirl.create(:restaurant, city: @city)
  @restaurant.menus.create(FactoryGirl.build(:menu).attributes)
  @menu = @restaurant.menus.first
  @restaurant.tables.create(FactoryGirl.build(:table, :for_today, menu: @menu).attributes)
  @table = @restaurant.tables.first

  he = FactoryGirl.create(:user, :with_customer_id,  gender: :male)
  she = FactoryGirl.create(:user, :with_customer_id,  gender: :female)

  FactoryGirl.create(:reservation, user: he, table: @table, date: @table.date, customer: "123")
  FactoryGirl.create(:reservation, user: he, table: @table, date: @table.date, customer: "456")
  FactoryGirl.create(:reservation, user: she, table: @table, date: @table.date, customer: "243")
  FactoryGirl.create(:reservation, user: she, table: @table, date:@table.date, customer: "987")
  
  return_value = Hash.new
  return_value[:id] = "123"
  allow_any_instance_of(Reservation).to receive(:create_stripe_charge) do |entity|
    entity.user.customer ? return_value : nil
  end
  allow_any_instance_of(Reservation).to receive(:stripe_capture).and_return return_value
  allow_any_instance_of(Reservation).to receive(:stripe_refund).and_return return_value 

  TableManager.process_today_tables

  allow(DateTime).to receive(:now).and_return DateTime.now.change({ hour: 12, min: 00, sec: 00 })
end

Given(/^I have preferences$/) do
  @user.preference = Preference.new
  @user.preference.city = @city
  @user.save!
end



When(/^I search a plan for today$/) do
  step "I go to the user page"
  find("#new-reservation-link").trigger("click")
  find(".today").trigger("click")

  page.execute_script("onTime()")

    click_on "Buscar mesas"
  within(".search-results") do 
    click_on "Reservar"
  end

  step("I fill in the credit card with valid details")

  find("#continuar").trigger("click")


end

Then(/^I can see the new reservation$/) do
  sleep(1)
  expect(page).to have_content("El estado del plan es RESERVADO")
  expect(page).to have_content("Antes de las 18h00 te comunicaremos si tu plan se confirma.")
  expect(page).to have_content("Lo sentimos, no es posible cancelar las reservas en el mismo día del plan.")
  visit @user_path
  within(".my-reservations") do
    expect(page).to have_content(@restaurant.name)
  end

  click_on "Notificaciones"
  expect(page).to have_content("Tu plan diinner en el restaurante #{@restaurant.name} el día #{@table.date} se ha reservado correctamente.") 
end


When(/^The last minute process runs$/) do
  TableManager.process_last_minute_tables
end

Then(/^I can see my plan cancellation$/) do
   visit @user_path
  click_on "Notificaciones"

  expect(page).to have_content("Lo sentimos. Tu plan en el restaurante #{@restaurant.name}")
  expect(page).to have_content("ha sido cancelado") 
end

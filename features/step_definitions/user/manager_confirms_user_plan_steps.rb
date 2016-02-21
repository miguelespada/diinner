Given(/^I will expect a plan confirmation notification$/) do
 expect(EmailNotifications).to receive(:notify_plan_confirmation).exactly(3).times
end

Given(/^There is a plan closed for tomorrow$/) do
  @he = FactoryGirl.create(:user, :with_customer_id)
  @she = FactoryGirl.create(:user, :with_customer_id, gender: :female )
  reservation = FactoryGirl.create(:reservation, user: @he, table: @table)

  reservation =  FactoryGirl.create(:reservation, user: @she, table: @table)
  reservation.companies.create(age: 35, gender: :female)

  @user.customer = "123"
  @user.save!

  return_value = Hash.new
  return_value[:id] = "123"
  allow_any_instance_of(Reservation).to receive(:create_stripe_charge) do |entity|
    entity.user.customer ? return_value : nil
  end

  allow_any_instance_of(Reservation).to receive(:stripe_capture).and_return return_value
  allow_any_instance_of(Reservation).to receive(:stripe_refund).and_return return_value
end

Then(/^I can see the confirmation notification$/) do
  visit @user_path
  click_on "Notificaciones"
  expect(page).to have_content("Tu plan en el restaurante #{@restaurant.name} el día #{@table.date} se ha confirmado.") 
  
  find(".notification-list a").click
  expect(page).to have_content("El estado del plan es CONFIRMADO")

  click_on "Mis reservas"
  find(".has-events a").click
  expect(page).to have_content("El estado del plan es CONFIRMADO")


  visit @user_path
  within(".my-reservations") do
    expect(page).to have_content(@restaurant.name)
    find("a").click
  end
  expect(page).to have_content("El estado del plan es CONFIRMADO")
end
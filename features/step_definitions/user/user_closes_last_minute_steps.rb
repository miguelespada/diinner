Given(/^There is a new reservation$/) do

  she = FactoryGirl.create(:user, :with_customer_id,  gender: :female)
  FactoryGirl.create(:reservation, user: she, table: @table, date:@table.date)
end


Then(/^I can see the plan confirmation$/) do
  sleep(1)
  save_and_open_page
  expect(page).to have_content("El estado del plan es CONFIRMADO")
  expect(page).to have_content("Tu reserva se ha realizado correctamente")

  expect(page).to have_content("Lo sentimos, no es posible cancelar las reservas en el mismo día del plan.")
  visit @user_path
  within(".my-reservations") do
    expect(page).to have_content(@restaurant.name)
  end
end
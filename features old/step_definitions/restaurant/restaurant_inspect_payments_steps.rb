Then(/^I am logged as the reserved restaurant$/) do
  login_as_restaurant @restaurant
end

Then(/^I can see the restaurant reservation payments$/) do
  click_on "Payments"
  expect(page).to have_content(@user.name)
  within(".payment-amount") do
    expect(page).to have_content(20)
  end
  within(".payment-status") do
    expect(page).to have_content("Confirmed")
  end
end
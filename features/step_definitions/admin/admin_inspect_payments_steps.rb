Then(/^I can see the reservation payments$/) do
  click_on "Payments"
  expect(page).to have_content(@user.name)
  expect(page).to have_content(@restaurant.name)
  within(".payment-amount") do
    expect(page).to have_content(20)
  end
  within(".payment-status") do
    expect(page).to have_content("Confirmed")
  end
  find(".payment-id .show-link").click
  expect(page).to have_content("Stripe payment data")
end
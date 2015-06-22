Given(/^A user has evaluated a plan$/) do
    step "There are some available tables"
    step "I am a logged user"
    step "I reserve a table"
    step "The diinner has passed"
    step "I can evaluate the reservation"
    step "I logout"
end

Then(/^I can see the evaluation$/) do
  click_on "Reservations"
  within ".restaurant-reservation" do
    find(".show-link").click
  end
  expect(page).to have_content "The food was great"
end

Then(/^I can access the evaluation through the restaurant page$/) do
  click_on "Restaurants"
  within ".restaurant-name" do
    find(".show-link").click
  end
  within ".evaluation-comments" do
    expect(page).to have_content "The food was great"
  end
end

Then(/^I get notified about the evaluation$/) do
  click_on "Logs"
  # TODO define notification
end
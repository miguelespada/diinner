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
  step "I can see the evaluation row"
end

Then(/^I can access the evaluation through the menu$/) do
  within ".navigation" do
    click_on "Evaluations"
  end
  within "#evaluations" do
    step "I can see the evaluation row"
  end
end

Then(/^I can see the evaluation row$/) do
  within ".evaluation-restaurant" do
      expect(page).to have_content "3"
    end
    within ".evaluation-menu" do
      expect(page).to have_content "5"
    end
    within ".evaluation-fun" do
      expect(page).to have_content "true"
    end
    within ".evaluation-recommend" do
      expect(page).to have_content "false"
    end
    within ".evaluation-comments" do
      expect(page).to have_content "The food was great"
    end
end


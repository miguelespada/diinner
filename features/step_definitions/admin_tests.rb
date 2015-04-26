When(/^I create a new test$/) do
  click_on "Tests"
  click_on "New"
  fill_in "Question", with: "What do you prefer, A/B?"
  click_on "Create Test"
  expect(page).to have_content "Test was successfully created."
end

Then(/^I should see the test in list of tests$/) do
  click_on "Tests"
  expect(page).to have_content "What do you prefer, A/B?"
end
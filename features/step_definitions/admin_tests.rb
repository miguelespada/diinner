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

When(/^I delete a test$/) do
  click_on "Tests"
  within(:css, ".test-actions") do
    find(".delete").click
  end
end

Then(/^I should not see the test in the list of tests$/) do
  expect(page).to have_content "Test was successfully destroyed."
  click_on "Tests"
  expect(page).not_to have_content "What do you prefer, A/B?"
end
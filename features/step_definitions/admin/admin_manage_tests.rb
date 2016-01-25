When(/^I create a new test$/) do
  click_on "Tests"
  click_on "New"
  fill_in "Question", with: "What do you prefer, A/B?"
  fill_in "Caption a", with: "Option A"
  fill_in "Caption b", with: "Option B"
  select 2, :from => "test_expectativas"
  select -2, :from => "test_cultura"
  select 1, :from => "test_frikismo"
  select 0, :from => "test_foodie"
  select 2, :from => "test_estudios"
  select 1, :from => "test_belleza"
  select -2, :from => "test_humor"
  click_on "Create Test"
  expect(page).to have_content "Test was successfully created."
end

Then(/^I should see the test in list of tests$/) do
  click_on "Tests"
  expect(page).to have_content "What do you prefer, A/B?"
  expect(page).to have_content "Option A"
  expect(page).to have_content "Option B"
  within(".expectativas") do
    expect(page).to have_content "2"
  end
  within(".cultura") do
    expect(page).to have_content "-2"
  end
  within(".frikismo") do
    expect(page).to have_content "1"
  end
  within(".foodie") do
    expect(page).to have_content "0"
  end
  within(".estudios") do
    expect(page).to have_content "2"
  end
  within(".belleza") do
    expect(page).to have_content "1"
  end
  within(".humor") do
    expect(page).to have_content "-2"
  end
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

When(/^I edit a test$/) do
  click_on "Tests"
  within(:css, ".test-actions") do
    find(".edit").click
  end
  fill_in "Question", with: "What do you prefer, C/D?"
  fill_in "Caption a", with: "Option C"
  fill_in "Caption b", with: "Option D"
  click_on "Update Test"
  expect(page).to have_content "Test was successfully updated."
end

Then(/^I should see the updated test in the list of tests$/) do
  click_on "Tests"
  expect(page).to have_content "What do you prefer, C/D?"
  expect(page).to have_content "Option C"
  expect(page).to have_content "Option D"
end

Then(/^I can preview the test$/) do
  click_on "Tests"
  click_on "What do you prefer, A/B?"
  expect(page).to have_css ".phone-mockup"
  expect(page).to have_content "What do you prefer, A/B?"
  expect(page).to have_content "Option A"
  expect(page).to have_content "Option B"
end


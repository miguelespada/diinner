When(/^I create a new table$/) do
  click_on "Tables"
  click_on "New"
  fill_in "Date", with: "20/12/2015"
  click_button 'Create Table'
end

Then(/^I should see the table in the list of tables$/) do
  expect(page).to have_content "Table was successfully created."
  within(:css, ".table-date") do
    expect(page).to have_content "2015-12-20"
  end
  within(:css, ".table-slots") do
    expect(page).to have_content "3/3"
  end
  within(:css, ".table-status") do
    expect(page).to have_content "empty"
  end
end

When(/^I delete a table$/) do
  within(:css, ".table-actions") do
    find(".delete").click
  end
end

Then(/^I should not see the table in the list of tables$/) do
  expect(page).to have_content "Table was successfully destroyed."
  expect(page).not_to have_content "2015-12-20"
end


When(/^I edit a table$/) do
  click_on @restaurant.name
  find(".edit").click
  fill_in "Date", with: "13/07/2023"
  click_button 'Update Table'
end

Then(/^I should see the updated table in the list of tables$/) do
  expect(page).to have_content "Table was successfully updated."
  expect(page).to have_content "2023-07-13"
end


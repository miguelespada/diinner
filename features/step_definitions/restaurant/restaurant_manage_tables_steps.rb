When(/^I create a new table$/) do
  click_on "Tables"
  click_on "New"
  fill_in "Date", with: Date.today.strftime("%d/%m/%Y")
  fill_in "Hour", with: "19:00"
  click_button 'Create Table'
end

Then(/^I should see the table in the list of tables$/) do
  expect(page).to have_content "Table was successfully created."
  within(:css, ".table-date") do
    expect(page).to have_content Date.today.strftime("%d/%m/%Y")
  end
  within(:css, ".table-hour") do
    expect(page).to have_content "19:00"
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
  expect(page).not_to have_content Date.today.strftime("%d/%m/%Y")
end


When(/^I edit a table$/) do
  click_on @restaurant.name
  find(".edit").click
  fill_in "Date", with: "13/07/2023"
  fill_in "Hour", with: "20:30"
  click_button 'Update Table'
end

Then(/^I should see the updated table in the list of tables$/) do
  expect(page).to have_content "Table was successfully updated."
  expect(page).to have_content "13/07/2023"

  within(".table-hour") do
    expect(page).to have_content "20:30"
  end
end

Then(/^I can see the table in my calendar$/) do
  find('.calendar-link').click
  expect(page).to have_css ".calendar"
  within(".today") do
    within(".empty") do
      expect(page).to have_content "19:00"
      click_on "19:00"
    end
  end
  expect(page).to have_css ".table-id"
  within(".today") do
      click_on Date.today.day
  end
  expect(page).to have_css "td.table-id"
end

When(/^I duplicate a table$/) do
  within(:css, ".table-actions") do
    find(".repeat").click
  end
  check "today"
  fill_in "times", with: "1"
  click_on "Repeat"
end

Then(/^I should see there are two tables with the same day\/hour$/) do
  expect(page).to have_content "Tables successfully created."
  expect(page).to have_content Date.today, count:2
end

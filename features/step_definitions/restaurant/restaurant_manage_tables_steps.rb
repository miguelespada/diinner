When(/^I create a new table$/) do
  click_on "Tables"
  click_on "New"
  fill_in "Date", with: Date.tomorrow.strftime("%d/%m/%Y")
  fill_in "Hour", with: "19:00" 
  select "Dummy menu", from: :table_menu
  click_button 'Create Table'
end

When(/^I create a new table having a menu$/) do
  step "I create a menu"
  click_on "Tables"
  click_on "New"
  fill_in "Date", with: Date.tomorrow.strftime("%d/%m/%Y")
  fill_in "Hour", with: "19:00"
  select "Dummy menu", from: :table_menu
  click_button 'Create Table'
end

When(/^I create a new table with wrong date$/) do
  click_on "Tables"
  click_on "New"
  fill_in "Date", with: Date.today.strftime("%d/%m/%Y")
  fill_in "Hour", with: "19:00"
  click_button 'Create Table'
end

When(/^I should the wrong date error message$/) do
  expect(page).to have_content 'You can only create tables starting from tomorrow'
end

Then(/^I should see the table in the list of tables$/) do
  expect(page).to have_content "Table(s) was successfully created."
  within(:css, ".table-date") do
    expect(page).to have_content Date.tomorrow.strftime("%d/%m/%Y")
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
  within(:css, ".table-price") do
    expect(page).to have_content 20
  end
  within(:css, ".table-menu") do
    expect(page).to have_content "Dummy menu"
  end
end

When(/^I delete a table$/) do
  within(:css, ".table-actions") do
    find(".delete").click
  end
end

Then(/^I should not see the table in the list of tables$/) do
  expect(page).to have_content "Table was successfully destroyed."
  expect(page).not_to have_content Date.tomorrow.strftime("%d/%m/%Y")
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
  within(".has-events") do
    within(".empty") do
      expect(page).to have_content "19:00"
      click_on "19:00"
    end
  end
  expect(page).to have_css ".table-id"
  within(".has-events") do
      click_on Date.tomorrow.day
  end
  expect(page).to have_css "td.table-id"
end


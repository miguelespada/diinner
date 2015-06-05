When(/^I create multiple tables$/) do
  click_on "New"
  fill_in "Date", with: Date.tomorrow.strftime("%d/%m/%Y")
  fill_in "Hour", with: "21:00"
  select 2, :from => :table_number
  click_button 'Create Table'
end

Then(/^I should see there are multiple tables with the same day\/hour$/) do
  within("#tables") do
    expect(page).to have_content(Date.tomorrow, count: 2)
    expect(page).to have_content("21:00", count: 2)
  end
end


When(/^I duplicate a table$/) do
  within(:css, ".table-actions") do
    find(".repeat").click
  end
  check "today"
  fill_in "times", with: "1"
  click_on "Repeat"
end

Then(/^I should see there are more tables with the same day\/hour$/) do
  expect(page).to have_content "Tables successfully created."
  within all('.table-date').first do
    expect(page).to have_content Date.today
  end
  within all('.table-date').last do
    expect(page).to have_content Date.today
  end
end

When(/^I replicate a table$/) do
  within(:css, ".table-actions") do
    find(".repeat").click
  end
  fill_in "days", with: "1"
  fill_in "times", with: "1"
  click_on "Repeat"
end

Then(/^I should see there are equal tables in the next days at the same hour$/) do
  expect(page).to have_content "Tables successfully created."
  within all('.table-date').first do
    expect(page).to have_content Date.today
  end
  within all('.table-date').last do
    expect(page).to have_content Date.today + 1.days
  end
end


Then(/^I should see I need to create a menu before i can create a table$/) do
  click_on "Tables"
  click_on "New"
  expect(page).to have_content "You need to create a menu first."
end

And(/^I have created three menus$/) do
  step "I create a menu"
  step "I create a menu 40"
  step "I create a menu 60"
end

Then(/^I should see I can't create more menus$/) do
  click_on "Menus"
  click_on "New"
  expect(page).to have_content "You can't create more menus."
end

And(/^I have created a 40 price menu$/) do
  step "I create a menu 40"
end

Then(/^I should see I can't create a 40 price menu again$/) do
  click_on "Menus"
  click_on "New"
  page.has_select?("Price", :with_options => [20, 60]).should == true
  page.has_select?("Price", :with_options => [40]).should == false
end
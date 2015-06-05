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

When(/^I create a repeated table$/) do
  click_on "New"
  fill_in "Date", with: Date.tomorrow.strftime("%d/%m/%Y")
  fill_in "Hour", with: "22:00"
  fill_in :table_repeat_until, with: (Date.tomorrow + 1.month).strftime("%d/%m/%Y")
  click_button 'Create Table'
end

Then(/^I should see there are equal tables in the next weeks at the same hour$/) do
  within("#tables") do
    expect(page).to have_content(Date.tomorrow)
    expect(page).to have_content(Date.tomorrow + 1.week)
    expect(page).to have_content(Date.tomorrow + 2.weeks)
    expect(page).to have_content(Date.tomorrow + 3.weeks)
    expect(page).to have_content(Date.tomorrow + 4.weeks)
    expect(page).to have_content("22:00", count: 5)
  end
end


When(/^I can delete multiple tables at the time$/) do

  page.all('.table-check').each do |element|
    within element do
      check :table_ids_
    end
  end
  click_button "Delete selected"

   expect(page).not_to have_css(".table-id")

end

Then(/^I can only create a menu of each price$/) do
  step "I create a menu 20"
  page.has_select?("Price", :with_options => [20]).should == false
  step "I create a menu 40"
  page.has_select?("Price", :with_options => [20]).should == false
  page.has_select?("Price", :with_options => [40]).should == false
  step "I create a menu 60"
  page.has_select?("Price", :with_options => [20]).should == false
  page.has_select?("Price", :with_options => [40]).should == false
  page.has_select?("Price", :with_options => [60]).should == false
end


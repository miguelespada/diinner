Given(/^I can access to the user page$/) do
  @user = FactoryGirl.create(:user, name: "Javier", email: "javier@gmail.com")
  visit "http://localhost:8100/"
  click_on "User"
end

Then(/^I should be able to see my profile details$/) do
  expect(page).to have_content(@user.name)
  expect(page).to have_content(@user.email)
end

And(/^I should be able to see the user links$/) do
  expect(page).to have_content("My profile")
  expect(page).to have_content("New reservation")
  expect(page).to have_content("My reservations")
  expect(page).to have_content("Last minute plan")
end

When(/^I access to the profile page$/) do
  click_on "My profile"
  expect(page).to have_content("My profile")
end

Then(/^I should be able to see the profile links$/) do
  expect(page).to have_content("Diinner preferences")
  expect(page).to have_content("Need help?")
  expect(page).to have_content("Share Diinner")
end

When(/^I access to the preferences page$/) do
  step "I access to the profile page"
  click_on "Diinner preferences"
  expect(page).to have_content("Diinner Preferences")
end

Then(/^I should be able to see my preferences$/) do
  expect(page).to have_content(@user.gender)
  expect(page).to have_content(@user.birth)
end

And(/^I can modify my preferences$/) do
  choose "user-gender-female"
  fill_in "Birth", with: "20/01/1981"
  fill_in "max_age", with: "60"
  fill_in "min_age", with: "20"
  select "40", :from => "menu_price"
  select "Madrid", :from =>  "city"
  click_on "Submit"
end
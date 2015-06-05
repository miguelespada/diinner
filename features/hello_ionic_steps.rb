
Given(/^I do a request to ionic serve$/) do
  FactoryGirl.create(:user, name: "Javier")
  visit "http://localhost:8100/"
end

Then(/^I should be able to see the page$/) do
  expect(page).to have_content("Javier")
end
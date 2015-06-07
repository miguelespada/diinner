Given(/^I can access to my profile$/) do
  FactoryGirl.create(:user, name: "Javier", email: "javier@gmail.com")
  visit "http://localhost:8100/"
  click_on "My profile"
end

Then(/^I should be able to see my profile details$/) do
  expect(page).to have_content("Javier")
  expect(page).to have_content("javier@gmail.com")
end
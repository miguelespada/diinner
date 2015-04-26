Given(/^Is the first time I login as user$/) do
  step "I am a logged user"
  @user.first_login = true
end

Then(/^I should see the edit profile page$/) do
  expect(page).to have_content "Edit my profile"
end

When(/^I edit my profile page$/) do
  visit users_path
  click_on "Profile"
  click_on "Edit profile"
end

Then(/^I should see my profile updated$/) do
  expect(page).to have_content "Male"
  expect(page).to have_content "1981-01-20"
end

Then(/^I should see my user profile$/) do
  expect(page).to have_content "My profile"
  expect(page).to have_content "Avatar"
  expect(page).to have_content "Gender"
  expect(page).to have_content "Birth"
end

When(/^I change my user profile$/) do
  page.select('Male', :from => 'user_gender')
  # fill_in "Gender", with: false
  fill_in "Birth", with: "20/01/1981"
  click_on "Update User"
end


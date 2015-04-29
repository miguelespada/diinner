
Given(/^Is the first time I login as user$/) do
  step "I am a logged user"
end

Then(/^I should see the edit profile page$/) do
  expect(page).to have_content "Edit profile"
end

Then(/^I should see my profile updated$/) do
  expect(page).to have_content "male"
  expect(page).to have_content "1981-01-20"
end

Then(/^I should see my user profile$/) do
  within(:css, ".user-avatar") do
    expect(page).to have_css "img"
  end

  within(:css, ".user-gender") do
    expect(page).to have_content "male"
  end

  within(:css, ".user-birth") do
    expect(page).to have_css "1981-01-20"
  end
end

When(/^I change my user profile$/) do
  page.select('Male', :from => 'user_gender')
  fill_in "Birth", with: "20/01/1981"
  click_on "Update User"
end


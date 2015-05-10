When(/^I edit a user$/) do
  step "I list users"
  click_on @users[0].name
  find(".edit").click
  page.select('Male', :from => 'user_gender')
  fill_in "Birth", with: "20/01/1981"
  click_on "Update User"
end

Then(/^I should see the updated user in the list of users$/) do
  expect(page).to have_content "User was successfully updated."
  within(:css, ".user-gender") do
    expect(page).to have_content "male"
  end
  within(:css, ".user-birth") do
    expect(page).to have_content "1981-01-20"
  end
end
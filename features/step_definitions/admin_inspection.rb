Given(/^There are some users$/) do
  @users = []
  3.times do
    @users << FactoryGirl.create(:user)
  end
end

Given(/^There are some restaurants$/) do
  @restaurants = []
  3.times do
    @restaurants << FactoryGirl.create(:restaurant)
  end
end

Given(/^The elasticsearch index is syncronized$/) do
  Restaurant.__elasticsearch__.refresh_index!
  Restaurant.__elasticsearch__.client.cluster.health wait_for_status: 'yellow'
  User.__elasticsearch__.refresh_index!
  User.__elasticsearch__.client.cluster.health wait_for_status: 'yellow'
end


Then(/^I should see the users in the list of users$/) do
  click_on "Users"

  3.times do |i|   
    expect(page).to have_content @users[i].name
    expect(page).to have_content @users[i].email
    expect(page).to have_content @users[i].gender
    expect(page).to have_content @users[i].birth
  end
end

When(/^I do a search$/) do
  fill_in "query", with: @restaurants[0].name + " " + @users[0].name
  
  within(:css, "#search-form") do
    click_button "search-button"
  end
end

Then(/^I should see the entities matching my search$/) do
  expect(page).to have_content @restaurants[0].name
  expect(page).to have_content @users[0].name
end

When(/^I click on a restaurant$/) do
  click_on @restaurants[0].name
end

Then(/^I should see the restaurant details$/) do
  expect(page).to have_content @restaurants[0].name
  expect(page).to have_content @restaurants[0].email
end

When(/^I click on a user$/) do
  click_on @users[0].name
end

Then(/^I should see the user details$/) do
  expect(page).to have_content @users[0].name
  expect(page).to have_content @users[0].email
end

When(/^I list users$/) do
  visit admin_path
  click_on "Users"
end

Then(/^I should not see the user action links$/) do
  within(:css, ".container-fluid") do
    expect(page).not_to have_content "Logout"
    expect(page).not_to have_content "Test"
  end
end

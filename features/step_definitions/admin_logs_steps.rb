When(/^a new user is registered$/) do
  first_time_user_login
end

Then(/^I should see the log of the creation of the new user$/) do
  click_on "Logs"
  within(:css, "#logs") do
    expect(page).to have_content "New user"
    expect(page).to have_content @first_time_user.name
    expect(page).to have_content @first_time_user.created_at
  end
  # TODO add to shortlist
end

Then(/^I can access to the new user the data$/) do
  click_on @first_time_user.name
  expect(page).to have_content @first_time_user.email
end


When(/^a new restaurant is created$/) do
  @restaurant = FactoryGirl.create(:restaurant)
end

Then(/^I should see the log of the creation of the new restaurant$/) do
  click_on "Logs"
  within(:css, "#logs") do
    expect(page).to have_content "New restaurant"
    expect(page).to have_content @restaurant.name
    expect(page).to have_content @restaurant.created_at
  end
  # TODO add to shortlist
end

Then(/^I can access to the new restaurant the data$/) do
  click_on @restaurant.name
  expect(page).to have_content @restaurant.email
end

When(/^a user answers a test$/) do
  @user = FactoryGirl.create(:user, gender: "male")
  @test = FactoryGirl.create(:test, gender: "male")
  @test_response = TestResponse.create(response: @test.caption_A, user: @user, test: @test)
end

Then(/^I should see the log of the creation of the new test response$/) do
 click_on "Logs"
  within(:css, "#logs") do
    expect(page).to have_content "New test"
    expect(page).to have_content @test.caption_A
    expect(page).to have_content @test_response.created_at
  end
end

Then(/^I can access to the test response data$/) do
  click_on @test.caption_A
  expect(page).to have_content @test.question
  expect(page).to have_content @user.name
end

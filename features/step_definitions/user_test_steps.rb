When(/^A test has been created$/) do
  @test = FactoryGirl.create(:test)
end

When(/^I go to the test page$/) do
  step "I go to the user page"
  find(".test").click()
end

When(/^I do a test$/) do
  choose "A"
  click_on "Reply"
end

Then(/^I should have a test done$/) do
  @test_response = TestResponse.where(user: @user).first
  expect(@test_response.user).to eq(@user)
end

When(/^I have done a test$/) do
  step "I go to the test page"
  step "I do a test"
  step "I should have a test done"
end

Then(/^I cant do the test$/) do
  step "I go to the test page"
  step "I should see the user page"
end

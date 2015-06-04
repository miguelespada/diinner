Given(/^I do a test$/) do
  @test = FactoryGirl.create(:test)
  @test2 = FactoryGirl.create(:test)
  step "I go to the user page"
  find(".test").click()
  click_on @test.caption_A
end

Then(/^I should be notified that I have done a test$/) do
  expect(page).to have_content("Test was successfully sent.")
end

Then(/^I cannot do anymore tests$/) do
  click_on @test2.caption_B
  expect(page).to have_content("You have completed all the tests.")
end
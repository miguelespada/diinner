Given(/^I do a test$/) do
  @test = FactoryGirl.create(:test,  :with_images)
  step "I go to the user page"
  click_on "Test"
  find(".option_A").click
end

Then(/^I cannot do anymore tests$/) do
  expect(page).to have_content("You have completed all the tests.")
end
Given(/^I do a test$/) do
  @test = FactoryGirl.create(:test,  :with_images)
  step "I go to the user page"
  find(".test").click()
  within(".option_A") do
    find('a').click
  end
end

Then(/^I cannot do anymore tests$/) do
  expect(page).to have_content("You have completed all the tests.")
end
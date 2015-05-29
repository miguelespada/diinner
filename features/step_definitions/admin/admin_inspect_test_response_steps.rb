Given(/^A user has done a test$/) do
  step "I am a logged user"
  @test = FactoryGirl.create(:test)
  step "I go to the user page"
  find(".test").click()
  click_on @test.caption_A
  step "I logout"
end

Then(/^I can see the test response$/) do
  click_on "Tests"
  click_on @test.question
  within('.test-responses') do
    expect(page).to have_content @user.name
    expect(page).to have_content @test.caption_A
  end
end

Then(/^I can see the user test responses$/) do
  click_on "Users"
  within "#content" do
    click_on @user.name
  end
  within('.test-responses') do
    expect(page).to have_content @test.question
    expect(page).to have_content @test.caption_A
  end
end
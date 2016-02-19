Given(/^I do a test$/) do
  @test = FactoryGirl.create(:test,  :with_images, humor: 1)
  @test_2 = FactoryGirl.create(:test, :with_images, humor: -2)
  step "I go to the user page"
  find("#test-A").click
  find("#test-A").click
  expect(@user.profile(:humor)).to eq -0.5

  @user.test_profile = nil
  @user.save!
  expect(@user.profile(:humor)).to eq -0.5
end

Then(/^I cannot do anymore tests$/) do
  expect(page).to have_content("Has completado todos los tests de compatibilidad")
end

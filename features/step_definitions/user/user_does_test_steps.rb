Given(/^I do a test$/) do
  FactoryGirl.create(:test,  :with_images, humor: 1, gender: :undefined)
  FactoryGirl.create(:test, :with_images, humor: -2, gender: :male)
  FactoryGirl.create(:test, :with_images, humor: -2, gender: :female)

  expect(@user.test_completed.count).to eq 0
  expect(Test.count).to eq 3

  expect(@user.test_pending.count).to eq 2

  step "I go to the user page"

  find("#test-A").click
  find("#test-A").click
  expect(@user.profile(:humor)).to eq -0.5

  step("The profile is regenerated if not exists")
end

Then(/^The profile is regenerated if not exists$/) do
  @user.test_profile = nil
  @user.save!
  expect(@user.profile(:humor)).to eq -0.5
end

Then(/^I cannot do anymore tests$/) do
  expect(page).to have_content("Has completado todos los tests de compatibilidad")
end


When(/^More tests are added$/) do
  @test = FactoryGirl.create(:test,  :with_images, humor: 2)
end

When(/^I can skip some tests$/) do
  visit users_path
  click_on "Saltar pregunta"
  expect(@user.test_completed_unskipped.count).to eq 2
  expect(@user.profile(:humor)).to eq -0.5

end

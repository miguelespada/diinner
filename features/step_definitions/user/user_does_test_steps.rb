Given(/^I do a test$/) do
  FactoryGirl.create(:test,  :with_images, humor: 1, gender: :undefined)
  FactoryGirl.create(:test, :with_images, humor: -2, gender: :male)
  FactoryGirl.create(:test, :with_images, humor: -2, gender: :female)
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


When(/^More tests are added$/) do
  @test = FactoryGirl.create(:test,  :with_images, humor: 2)
end

When(/^I can skip some tests$/) do
  visit users_path
  click_on "Saltar pregunta"
  expect(@user.cached_test_completed.count).to eq 2
  expect(@user.profile(:humor)).to eq -0.5
end

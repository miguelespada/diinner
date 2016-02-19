Given(/^I do a test$/) do
  @test = FactoryGirl.create(:test,  :with_images)
  step "I go to the user page"
  save_and_open_page
  find("#test-A").click

end

Then(/^I cannot do anymore tests$/) do
  expect(page).to have_content("Has completado todos los tests de compatibilidad")
end
Then(/^I should see the user login panel$/) do
  page.should have_css "#login-panel"
end

Given(/^I am a logged user$/) do
  @user = FactoryGirl.create(:user, :returning)
  login_as_user @user
  visit users_path
end

Then(/^I should see the user page$/) do
  expect(page).to have_content @user.name
end

When(/^I go to the user page$/) do
  visit users_path
end

Given(/^I am a first login user$/) do
  @user = FactoryGirl.create(:user, :first_login)
  login_as_user @user
  visit users_path
end

Then(/^I should see the edit preferences page$/) do
  expect(page).to have_content "¡¡Bienvenido a Diinner!!"
end


When(/^I go to the preferences page$/) do
  visit users_path
  click_on "Preferencias"
end

When(/^I drop out$/) do
  step "I go to the preferences page"
  click_on "Darse de baja"
  sleep(1)
  click_on "Hidden Drop Out"
end

When(/^I should see my preferences have been reset$/) do
  expect(page).to have_content "Muchas gracias por haber usado nuestra plataforma, esperamos volver verte pronto."
  login_as_user @user
  visit users_path
  expect(page).to have_content "¡¡Bienvenido a Diinner!!"
end
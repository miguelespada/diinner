Given(/^The site is protected$/) do
  site_protected
end

Then(/^I should see the protected page$/) do
  expect(page).to have_content "En estos momentos estamos a tope."
end

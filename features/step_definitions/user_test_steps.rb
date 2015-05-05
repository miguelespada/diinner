When(/^I go to the test page$/) do
  step "I go to the user page"
  find(".test").click()
end

When(/^I do a test$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see a test has been done$/) do
  pending # express the regexp above with the code you wish you had
end

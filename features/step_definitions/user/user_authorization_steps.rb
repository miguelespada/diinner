When(/^I visit other user data$/) do
  @other = FactoryGirl.create(:user)
  visit user_path(@other)
end

When(/^I try to edit the other user data$/) do
  visit edit_user_path(@other)
end
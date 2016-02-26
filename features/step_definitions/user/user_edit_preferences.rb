When(/^I edit my preferences$/) do
  step "I go to the preferences page"
  find(:select, 'user_gender').find("option[value='female']").select_option
  fill_in "user_birth", with: "16/01/1980"
  find(".after-toggle[data-after='1']").trigger("click")
  find(".price-toggle[data-price='premium']").trigger("click") #todo price not working
  click_on "Guardar"
end

Then(/^I can see my preferences have been updated$/) do
  expect(@user.gender).to eq :female
  expect(@user.birth).to eq Date.strptime("16/01/1980", "%d/%m/%Y")
  expect(@user.preference.after_plan).to eq true
  # expect(@user.preference.menu_range).to eq :regular #todo price not working
end

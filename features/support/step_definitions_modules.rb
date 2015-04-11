module Login
  def login user
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button 'Log in'
  end 

  def login_as_admin admin
    visit new_admin_session_path
    login admin
  end

  def login_as_restaurant restaurant
    visit new_restaurant_session_path
    login restaurant
  end
end

World(Login)
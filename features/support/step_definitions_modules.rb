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

  def login_as_user user
    allow_any_instance_of(UserSession).to receive(:logged?).and_return(true)
    allow_any_instance_of(UserSession).to receive(:user_from_session).and_return(user)
  end

  def first_time_user_login
    @first_time_user = FactoryGirl.create(:user, :first_login)
    login_as_user @first_time_user
  end
end

World(Login)
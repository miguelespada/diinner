module Login
  def login user
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button 'Log in'
  end

  def login_as_admin admin
    visit admin_path
    login admin
  end

  def login_as_restaurant restaurant
    visit new_restaurant_session_path
    login restaurant
  end

  def first_password_restaurant_login
    @restaurant = FactoryGirl.create(:restaurant, :first_password)
    login_as_restaurant(@restaurant)
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

module Ajax
  def ajax_call method
    send(method)
  end

  def google_api
     page.execute_script("$('.restaurant_latitude input').val('40.012345')")
     page.execute_script("$('.restaurant_longitude input').val('5.056789')")
  end
end

module Cache

  def disable_cache
    Rails.application.configure do
      config.cache_store = :null_store
    end
  end
end

module Cards
  def valid_card
    {card: {
    name: "Rodrigo Rato",
    number: "4012888888881881",
    exp_month: '09',
    exp_year: '2020',
    cvc: '123'
    }}
  end

end


World(Login)
World(Ajax)
World(Cards)
World(Cache)
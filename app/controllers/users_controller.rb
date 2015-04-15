class UsersController < ActionController::Base

  def login
  end

  def show
    @user = session[:userinfo]
  end
end

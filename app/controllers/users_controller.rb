class UsersController < ActionController::Base

  before_action :logged_in_using_omniauth?, except: [:login]
  before_action :import_omniauth_info, only: [:show]

  def index
  end

  def login
  end

  def show
    @user = user_from_session
  end

  private

  def logged_in_using_omniauth?
      redirect_to users_login_path unless session[:userinfo].present?
  end

  def import_omniauth_info
      user = user_from_session
      if user.nil?
        User.create(hash_from_omniauth)
      else
        user.update(hash_from_omniauth)
      end
  end

  def hash_from_omniauth
    logged_user_info = session[:userinfo][:info]
    {
      email: logged_user_info[:email],
      image_url: logged_user_info[:image],
      name: logged_user_info[:name]
    }
  end

  def user_from_session
    User.where(email: session[:userinfo][:info][:email]).first
  end

end

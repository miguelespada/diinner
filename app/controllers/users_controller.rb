class UsersController < ActionController::Base
  before_action :logged?, except: [:login]
  before_action :set_user, only: [:show]

  def index
  end

  def login
  end

  def show
  end

  private

  def logged?
    @userSession = UserSession.new(session)
    redirect_to users_login_path unless @userSession.logged?
  end

  def set_user
    @user = @userSession.user_from_session
  end
end

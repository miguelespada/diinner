class UsersController < ActionController::Base
  before_action :authorize, except: [:login]

  def index
  end

  def login
  end

  def show
    @user = UserSession.new(session).user_from_session
  end

  private

  def authorize
    redirect_to users_login_path unless UserSession.new(session).logged?
  end
end

class BaseUsersController < ApplicationController
  layout "user"
  before_action :create_session
  before_action :authenticate, except: [:login]
  load_resource :user
  before_action :authorize!

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if @current_user != @user
  end

  def authenticate
    if @session.logged?
      @current_user = @session.user_from_session
    else
      redirect_to users_login_path
    end
  end

  def create_session
    @session ||= UserSession.new(session)
  end

end
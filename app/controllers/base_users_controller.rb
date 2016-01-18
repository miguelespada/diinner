class BaseUsersController < ApplicationController
  layout "user"
  before_action :create_session
  before_action :authenticate, except: [:login]
  before_action :redirect, only: [:users]
  load_resource :user
  before_filter :sign_out_others
  before_action :authorize!

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if @current_user != @user
  end

  def authenticate
    if @session.logged?
      @current_user = @session.user_from_session
    else
      redirect_to root_path
    end
  end

  def create_session
    @session ||= UserSession.new(session)
  end

  def redirect
    redirect_to user_path(@current_user)
  end

  def users
  end

  def sign_out_others
    sign_out(current_restaurant) if restaurant_signed_in?
    sign_out(current_admin) if admin_signed_in?
  end

end
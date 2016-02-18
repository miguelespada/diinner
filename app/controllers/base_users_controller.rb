class BaseUsersController < ApplicationController
  layout "user"
  before_action :create_session
  before_action :authenticate, except: [:login]
  before_action :redirect, only: [:users]
  before_action :load_resource
  before_filter :sign_out_others
  before_action :authorize!
  before_action :check_protected
  before_action :first_login, except: [:edit, :update]

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if @current_user != @user
  end

  def load_resource
    @user = User.find(params[:user_id] || params[:id])
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

  def check_protected
    redirect_to protected_path if AdminSettings.is_protected? and @current_user.first_login?
  end

  def first_login
    redirect_to edit_user_path(@current_user) if @current_user.first_login?
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
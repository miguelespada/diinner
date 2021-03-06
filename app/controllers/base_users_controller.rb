class BaseUsersController < ApplicationController
  layout "user"
  before_action :create_session
  before_action :authenticate, except: [:login]
  before_action :redirect, only: [:users]
  before_filter :sign_out_others
  before_action :load_and_authorize_resource!
  before_action :check_protected
  before_action :first_login, except: [:edit, :update]


  def load_and_authorize_resource!
    id = @current_user.id
    if( id.to_s == params[:user_id] || id.to_s == params[:id] )
      @user = @current_user
    else
      raise CanCan::AccessDenied.new("Not authorized!")
    end
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
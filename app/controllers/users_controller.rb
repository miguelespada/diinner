class UsersController < ApplicationController
  layout "user"
  before_action :create_session
  before_action :authenticate, except: [:login]
  load_resource :only => [:show, :edit, :update, :notifications]
  before_action :authorize!, :only => [:edit, :update]
  before_action :redirect_if_first_login, only: [:index, :show]

  def index
    redirect_to user_path(@current_user)
  end

  def login
    render :layout => false
  end

  def edit
    @current_user.preference ||= Preference.new
  end

  def show
  end

  def update
    if @current_user.update(user_params)
      redirect_to user_path(@current_user), notice: 'Your profile was successfully updated.'
    else
      render :edit
    end
  end

  def notifications
    @notifications = PublicActivity::Activity.where(recipient: @user).desc(:created_at).page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:gender,
                                  :birth,
                                  :preference_attributes => [:max_age, :min_age, :city_id, :id])
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

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@user.is_owned_by?(@current_user)
  end

  def redirect_if_first_login
    redirect_to edit_user_path(@current_user) if @current_user.first_login?
  end

end
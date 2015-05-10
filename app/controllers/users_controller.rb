class UsersController < ApplicationController
  layout "user"
  before_action :create_session
  before_action :authenticate, except: [:login]
  load_resource :only => [:show, :edit, :update]
  before_filter :authorize!, :only => [:edit, :update]

  def index
    # TODO this should be a before filter (not only for index)
    if @current_user.first_login?
      redirect_to edit_user_path(@current_user) 
    else
      redirect_to user_path(@current_user) 
    end
  end

  def login
  end

  def edit
  end

  def show
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Your profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:gender,
                                  :birth)
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
end

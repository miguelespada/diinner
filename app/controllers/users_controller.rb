class UsersController < ApplicationController
  layout "user"
  before_action :create_session
  before_action :authenticate, except: [:login]
  load_resource :only => [:show, :edit, :update]
  before_action :authorize!, :only => [:edit, :update]
  before_action :check_first_login, except: [:login, :edit, :update]

  def index
    redirect_to user_path(@current_user)
  end

  def login
  end

  def edit
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

  def check_first_login
    if @current_user.first_login?
      redirect_to edit_user_path(@current_user)
    end
  end

end
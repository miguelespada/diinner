class UsersController < ActionController::Base
  before_action :create_session
  before_action :authorize, except: [:login]

  def index
    @user = @session.user_from_session
    redirect_to edit_user_path(@user) if @user[:first_login]
  end

  def login
  end

  def edit
    @user = @session.user_from_session
  end

  def show
    @user = @session.user_from_session
  end

  def profile

  end

  private

  def authorize
    redirect_to user_login_path unless @session.logged?
  end

  def create_session
    @session ||= UserSession.new(session)
  end
end

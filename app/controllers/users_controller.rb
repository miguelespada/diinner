class UsersController < ActionController::Base
  layout "user"
  before_action :create_session
  before_action :authenticate, except: [:login]

  def index
    if @user.first_login?
      redirect_to edit_user_path(@user) 
    else
      render :show
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
      @user = @session.user_from_session
    else
      redirect_to users_login_path
    end
  end

  def create_session
    @session ||= UserSession.new(session)
  end
end

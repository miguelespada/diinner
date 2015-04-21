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

  def update
    @user = @session.user_from_session
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: 'Your profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:gender,
                                  :birth,
                                  )
  end

  def authorize
    redirect_to user_login_path unless @session.logged?
  end

  def create_session
    @session ||= UserSession.new(session)
  end
end

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
    if @user.update(user_params)
      # TODO update + save?
      @user[:first_login] = false
      # TODO use rails sintax
      @user.save
      redirect_to user_path(@user), notice: 'Your profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:gender,
                                  :birth,
                                  )
  end

  def authorize
    redirect_to users_login_path unless @session.logged?
  end

  def create_session
    @session ||= UserSession.new(session)
  end
end

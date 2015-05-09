class  Admin::UsersController < AdminController
  before_filter :authenticate_admin!
  load_resource :only => [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:gender,
                                 :birth)
  end

end

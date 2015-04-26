class  Admin::UsersController < AdminController
  before_filter :authenticate_admin!
  load_resource :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'User was successfully destroyed.' }
    end
  end


end

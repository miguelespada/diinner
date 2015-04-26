class  Admin::UsersController < AdminController
  before_filter :authenticate_admin!
  load_resource :only => [:show, :edit, :update, :destroy]


  # TODO Do not add code wihtout test

  def index
    @users = User.all
  end

  # TODO Do not copy paste!
  # WTF! Why create accions

  def new
  end

  def create
  end

  # TODO we do not want to detroy users, this is not a requirement

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'User was successfully destroyed.' }
    end
  end

end

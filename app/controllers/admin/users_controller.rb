class  Admin::UsersController < AdminController
  before_filter :authenticate_admin!

  def index
    @users = User.all
  end

end

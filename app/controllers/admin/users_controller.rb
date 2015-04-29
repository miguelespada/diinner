class  Admin::UsersController < AdminController
  before_filter :authenticate_admin!
  load_resource :only => [:show]

  def index
    @users = User.all
  end

  def show
  end 

end

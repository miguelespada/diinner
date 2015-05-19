class  ReservationsController < UsersController
  before_action :load_user

  def new
  end

  private

  def load_user
    @user = User.find(params["user_id"])
  end

end

class  Users::NotificationsController < BaseUsersController

  def index
    @notifications = @user.notifications.page(params[:page])
  end

end
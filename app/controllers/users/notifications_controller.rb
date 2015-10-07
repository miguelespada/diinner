class  Users::NotificationsController < BaseUsersController

  def index
    @notifications = @user.notifications.page(params[:page])
    @user.read_notifications
  end

end
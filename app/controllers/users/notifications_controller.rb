class  Users::NotificationsController < BaseUsersController

  def index
    @notifications = @user.notifications
    @user.read_notifications
  end

end
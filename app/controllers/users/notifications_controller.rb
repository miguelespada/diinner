class  Users::NotificationsController < BaseUsersController
  caches_action :index, expires_in: 10.minutes

  def index
    @notifications = @user.notifications
    @user.read_notifications
  end

end
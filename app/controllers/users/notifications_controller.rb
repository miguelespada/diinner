class  Users::NotificationsController < BaseUsersController

  def index
    @notifications = @user.notifications.desc(:created_at).page(params[:page])
    @user.read_notifications
  end

end
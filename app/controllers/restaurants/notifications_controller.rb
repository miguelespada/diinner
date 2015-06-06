class Restaurants::NotificationsController <  BaseRestaurantsController

  def index
    @notifications = @restaurant.notifications.page(params[:page])
  end

end
class RestaurantsController < BaseRestaurantsController
  load_resource :user, :only => [:user]

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path, notice: 'Your profile was successfully updated.'
    else
      render :edit
    end
  end

  def show
  end

  def notifications
    @notifications = @restaurant.notifications.page(params[:page])
  end

  def user
    CanCan::AccessDenied.new("Not authorized!") if !@restaurant.is_customer?(@user)
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(Restaurant.permitted_params)
  end

end
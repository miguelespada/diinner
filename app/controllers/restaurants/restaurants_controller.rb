class Restaurants::RestaurantsController < BaseRestaurantsController
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

  private
  def restaurant_params
    params.require(:restaurant).permit(Restaurant.permitted_params)
  end

end
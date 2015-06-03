class  Admin::RestaurantsController < AdminController
  load_resource :only => [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def show
  end

  def edit
  end

  def create
    @restaurant = Restaurant.create!(restaurant_params)
    @restaurant.create_activity key: 'restaurant.create', owner: current_admin
    redirect_to admin_restaurants_path, :notice => 'Restaurant was successfully created.'
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to admin_restaurant_path, notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path, notice: 'Restaurant was successfully destroyed.'
  end


  private

  def restaurant_params
    params.require(:restaurant).permit(Restaurant.permitted_params)
  end
end

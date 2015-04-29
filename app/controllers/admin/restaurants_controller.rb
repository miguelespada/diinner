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

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save!
    redirect_to admin_restaurants_path, :notice => 'Restaurant was successfully created.'
  end

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path, notice: 'Restaurant was successfully destroyed.'
  end


  private

  def restaurant_params
    params.require(:restaurant).permit(:name, 
                                :password, 
                                :email)
  end
end

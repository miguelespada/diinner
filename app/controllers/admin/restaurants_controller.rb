class  Admin::RestaurantsController < AdminController
  before_filter :authenticate_admin!
  load_resource :only => [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save
    redirect_to admin_restaurants_path, :notice => 'Restaurant was successfully created.'
  end

  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to admin_restaurants_path, notice: 'Restaurant was successfully destroyed.' }
    end
  end


  private

  def restaurant_params
    params.require(:restaurant).permit(:name, 
                                :password, 
                                :email)
  end
end

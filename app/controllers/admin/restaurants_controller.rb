class  Admin::RestaurantsController < AdminController
  load_resource :only => [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.desc(:created_at).page(params[:page])
  end

  def new
    @restaurant = Restaurant.new
  end

  def show
  end

  def edit
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save!
    @restaurant.create_activity key: 'restaurant.create', owner: current_admin, recipient: Admin.first
    redirect_to admin_restaurants_path, :notice => 'Restaurant was successfully created.'
  rescue
    render :new
  end

  def update
    @restaurant.update!(restaurant_params)
    redirect_to admin_restaurant_path, notice: 'Restaurant was successfully updated.'
  rescue
    render :edit
  end

  def destroy
    if @restaurant.can_be_deleted?
      @restaurant.destroy
      redirect_to admin_restaurants_path, notice: 'Restaurant was successfully destroyed.'
    else
      redirect_to admin_restaurants_path, notice: 'This restaurant cannot be deleted.'
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(Restaurant.permitted_params)
  end
end

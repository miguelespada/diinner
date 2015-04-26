class RestaurantsController < ActionController::Base
  layout "restaurants"
  before_filter :authenticate_restaurant!
  load_resource :only => [:show, :profile, :edit, :update]

  def index
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      format.html { redirect_to restaurants_profile_path, notice: 'Your profile was successfully updated.' }
    else
      format.html { render :edit }
    end
  end

  def show
  end

  def profile
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name,        
                                       :description, 
                                       :phone,       
                                       :address)     
  end
end

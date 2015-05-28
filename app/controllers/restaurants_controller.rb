class RestaurantsController < ApplicationController
  layout "restaurants"
  before_filter :authenticate_restaurant!

  load_resource :only => [:show, :edit, :update, :reservations, :user, :calendar]
  before_filter :authorize!, :only => [:edit, :update, :reservations, :user, :calendar]

  def index
  end

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

  def reservations
    @reservations = @restaurant.reservations
  end

  def user
    @user = User.find(params["user_id"])
    CanCan::AccessDenied.new("Not authorized!") if !@restaurant.is_customer?(@user)
  end

  def calendar
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(Restaurant.permitted_params)
  end

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@restaurant.is_owned_by?(current_restaurant)
  end
end
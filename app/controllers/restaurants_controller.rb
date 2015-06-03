class RestaurantsController < ApplicationController
  layout "restaurants"
  before_filter :authenticate_restaurant!

  # TODO compact form
  load_resource :only => [:show, :edit, :update, :user, :notifications, :update_password, :edit_password]
  before_filter :authorize!, :only => [:edit, :update, :user, :notifications, :update_password, :edit_password]

  def index
  end

  def edit
  end

  def edit_password
  end

  def update_password
    if @restaurant.update_with_password(restaurant_password_params)
      sign_in @restaurant, :bypass => true
      redirect_to restaurant_path, notice: 'Your password was successfully updated.'
    else
      render :edit_password
    end
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
    @user = User.find(params["user_id"])
    CanCan::AccessDenied.new("Not authorized!") if !@restaurant.is_customer?(@user)
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(Restaurant.permitted_params)
  end

  def restaurant_password_params
    params.require(:restaurant).permit(:password, :password_confirmation, :current_password)
  end

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@restaurant.is_owned_by?(current_restaurant)
  end
end
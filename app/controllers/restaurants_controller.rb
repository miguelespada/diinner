class RestaurantsController < ApplicationController
  layout "restaurants"
  before_filter :authenticate_restaurant!

  load_resource :only => [:show, :edit, :update, :reservations, :user, :calendar, :validate_reservation]
  before_filter :authorize!, :only => [:edit, :update, :reservations, :user, :calendar, :validate_reservation]

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
    @table = @restaurant.tables.find(params[:table_id]) if params[:table_id].present?
    @date_tables = @restaurant.tables.where(:date => Date.strptime(params[:date])) if params[:date].present?
    @tables = @restaurant.tables
  end

  def validate_reservation
    reservation = Reservation.find(params["reservation_id"])
    reservation.ticket_valid = params[:ticket_valid]
    reservation.save!
    redirect_to restaurant_reservations_path(@restaurant)
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(Restaurant.permitted_params)
  end

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@restaurant.is_owned_by?(current_restaurant)
  end
end
class Restaurants::ReservationsController < ApplicationController
  layout "restaurants"
  before_filter :authenticate_restaurant!
  before_filter :load_restaurant
  before_filter :load_reservation, :except => [:index]
  before_filter :authorize!
  before_action :redirect_if_first_password

  def show
  end

  def index
    @reservations = @restaurant.reservations
  end

  def validate
    @reservation.ticket_valid = params[:ticket_valid]
    @reservation.save!
    redirect_to :back
  end

  private
  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def load_reservation
    params[:id] ||= params[:reservation_id]
    @reservation = @restaurant.reservations.find(params[:id])
  end

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@restaurant.is_owned_by?(current_restaurant)
  end

  def redirect_if_first_password
    # TODO WTF -> not DRY
    redirect_to edit_restaurant_password_path(current_restaurant), notice: 'Your must change your password.' if current_restaurant.first_password?
  end
end
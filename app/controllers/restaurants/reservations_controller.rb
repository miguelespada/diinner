class Restaurants::ReservationsController <  BaseRestaurantsController
  load_resource :only => [:show], :through => :restaurant
  load_resource :reservation, :id_param => :reservation_id, :only => [:validate], :through => :restaurant

  def index
    @reservations = @restaurant.reservations
  end

  def show
  end

  def validate
    @reservation.update(ticket_valid: params[:ticket_valid])
    redirect_to :back
  end

end
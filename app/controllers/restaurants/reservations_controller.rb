class Restaurants::ReservationsController <  BaseRestaurantsController
  load_resource :only => [:show], :through => :restaurant

  def index
    @reservations = @restaurant.reservations
  end

  def show
  end

  def validate
    @reservation = @restaurant.reservations.find(params[:reservation_id])
    @reservation.update(ticket_valid: params[:ticket_valid])
    redirect_to :back
  end

end
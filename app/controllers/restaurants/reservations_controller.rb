class Restaurants::ReservationsController <  BaseRestaurantsController
  load_resource :only => [:index], :through => :restaurant
  load_resource :reservation, :only => [:validate], :through => :restaurant

  def index
    @reservations = @restaurant.reservations
  end

  def show
  end

  def validate
    @reservation.ticket_valid = params[:ticket_valid]
    @reservation.save!
    redirect_to :back
  end

end
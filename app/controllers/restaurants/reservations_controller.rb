class Restaurants::ReservationsController <  BaseRestaurantsController
  load_resource :only => [:show, :search_by_ticket], :through => :restaurant

  def index
    @reservations = @restaurant.reservations.page(params[:page])
  end

  def show
  end

  def validate
    @reservation = @restaurant.reservations.find(params[:reservation_id])
    @reservation.update(ticket_valid: params[:ticket_valid])
    redirect_to :back
  end

  def search_by_ticket
    query = params[:query]
    @reservations = @restaurant.reservations.where(locator:  /.*#{query}.*/ ).page(params[:page]) if !query.nil?
  end
end
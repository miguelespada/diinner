class Admin::ReservationsController < AdminController
  load_resource :only => [:show]

  def index
    @reservations = Reservation.all
  end

  def show
  end

end
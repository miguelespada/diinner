class Admin::ReservationsController < AdminController
  load_resource :only => [:show]

  def index
    @reservations = Reservation.desc(:created_at).page(params[:page])
  end

  def show
  end

end
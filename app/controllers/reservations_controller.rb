class  ReservationsController < UsersController
  before_action :load_user
  load_resource :only => [:update, :destroy, :show]

  def index
    @reservations = @user.reservations.where(cancelled: false)
  end

  def new
    @reservation = @user.reservations.new
    @reservation.companies.build
    @reservation.companies.build
  end

  def show
  end

  def search
    # TODO limit search on Engine
    suggestionEngine = SuggestionEngine.new @user, params[:reservation]
    @suggestions = suggestionEngine.search.first(3)
  end

  def create
    # TODO check again if reservation match the table (in case concurrency problems)
    @reservation = @user.reservations.create(reservation_params)
    render :credit_card_form
  end

  def reuse_card
    # TODO get rid of load_resource...  create load_reservation
    @reservation = @user.reservations.find(params[:reservation_id])
    @reservation.create_activity key: 'reservation.create', owner: @user, recipient: @reservation.restaurant
    redirect_to user_reservations_path(@user), notice: 'Table reserved succesfully!'
  end

  def update
    if @user.update_customer_information!(params[:stripe_card_token])
      @reservation.create_activity key: 'reservation.create', owner: @user, recipient: @reservation.restaurant
      redirect_to user_reservations_path(@user), notice: 'Table reserved succesfully!'
    else
      @reservation.delete
      redirect_to user_reservations_path(@user), notice: 'There was an error processing your reservation :('
    end
  end

  def cancel
    # TODO apply cancellation fee
    @reservation = @user.reservations.find(params[:reservation_id])
    @reservation.cancel
    @reservation.create_activity key: 'reservation.cancel', owner: @user, recipient: @reservation.restaurant
    redirect_to user_reservation_path(@user, @reservation), notice: 'Reservation was successfully cancelled.'
  end

  def restaurant
    @restaurant = @user.reservations.find(params["reservation_id"]).restaurant
  end

  def menu
    @menu = @user.reservations.find(params["reservation_id"]).menu
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id,
                                       :date,
                                       :price,
                                       :table_id,
                                       :stripe_card_token,
                                       companies: [:id, :_gender, :age])
  end

  def authorize!
    # TODO authorize
  end

  def load_user
    @user = User.find(params["user_id"])
  end


end

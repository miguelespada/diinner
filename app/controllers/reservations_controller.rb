class  ReservationsController < UsersController
  load_resource :user
  load_resource :id_param => :reservation_id, :only => [:reuse_card, :cancel, :menu, :restaurant], :through => :user
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
    suggestionEngine = SuggestionEngine.new @user, params[:reservation]
    # TODO limit search on Engine
    @suggestions = suggestionEngine.search.first(3)
  end

  def create
    # TODO check again if reservation match the table (in case concurrency problems)
    @reservation = @user.reservations.create(reservation_params)
    render :credit_card_form
  end

  def reuse_card
    @reservation.notify "create"
    redirect_to user_reservations_path(@user), notice: 'Table reserved succesfully!'
  end

  def update
    if @user.update_customer_information!(params[:stripe_card_token])
      @reservation.notify "create"
      redirect_to user_reservations_path(@user), notice: 'Table reserved succesfully!'
    else
      # TODO handle properly errors
      @reservation.delete
      redirect_to user_reservations_path(@user), notice: 'There was an error processing your reservation :('
    end
  end

  def cancel
    @reservation.cancel
    @reservation.notify "cancel"
    redirect_to user_reservation_path(@user, @reservation), notice: 'Reservation was successfully cancelled.'
  end

  def restaurant
    @restaurant = @reservation.restaurant
  end

  def menu
    @menu = @reservation.menu
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

end
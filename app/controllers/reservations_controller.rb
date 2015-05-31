class  ReservationsController < UsersController
  before_action :load_user
  load_resource :only => [:update, :destroy, :show]
  before_action :authorize!

  def index
    @reservations = @user.reservations
  end

  def new
    # TODO maybe push to model??
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
    # TODO check that the payment is done without problems.
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

  def destroy
    # TODO add cancelled state instead of delete
    @reservation.delete
    redirect_to user_reservations_path(@user), notice: 'Reservation was successfully cancelled.'
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

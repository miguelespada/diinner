class  ReservationsController < UsersController
  before_action :load_user
  load_resource :only => [:update, :destroy]
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

  def search
    suggestionEngine = SuggestionEngine.new @user, params[:reservation]
    @suggestions = suggestionEngine.search
  end

  def create
    # TODO check again if reservation match the table (in case concurrency problems)
    @reservation = @user.reservations.create(reservation_params)
    render :credit_card_form
  end

  def reuse_card
    # TODO check that the payment is done without problems.
    redirect_to user_reservations_path(@user), notice: 'Table reserved succesfully!'
  end

  def update
    @user.update_customer_information!(params[:stripe_card_token])
    redirect_to user_reservations_path(@user), notice: 'Table reserved succesfully!'
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

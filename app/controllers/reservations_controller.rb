class  ReservationsController < UsersController
  before_action :load_user
  load_resource :only => [:update,:destroy]
  before_action :authorize!

  def index
    @reservations = @user.reservations
  end

  def new
    @reservation = @user.reservations.new
  end

  def create
    @reservation = @user.reservations.create(reservation_params)
    render :credit_card_form
  end

  def search
    suggestionEngine = SuggestionEngine.new @user
    @suggestions = suggestionEngine.search date_param, price_param, customer_count_param
    # TODO handle no suggestions
  end

  def update
    # TODO handle errors
    @reservation.update_customer_information!(params[:stripe_card_token])
    redirect_to user_reservations_path(@user), notice: 'Table reserved succesfully!'
  end

  def destroy
    @user.reservations.delete(@reservation)
    redirect_to  user_reservations_path(@user), notice: 'Reservation was successfully cancelled.'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id,
                                       :date,
                                       :price,
                                       :table_id,
                                       :stripe_card_token)
  end

  def authorize!
    # TODO authorize
  end

  def load_user
    @user = User.find(params["user_id"])
  end

  def customer_count_param
    # TODO add real customer count
    1
  end

  def date_param
    Date.strptime params[:reservation][:date]
  end

  def price_param
    price = params[:reservation][:price].to_i
  end

end

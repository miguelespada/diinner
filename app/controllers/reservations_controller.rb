class  ReservationsController < UsersController
  before_action :load_user
  load_resource :only => [:update]
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
    @suggestions = suggestionEngine.search date_param, price_param
    # TODO handle no suggestions
  end

  def update
    # TODO save payment token
    redirect_to user_reservations_path(@user), notice: 'Table reserved succesfully!'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id,
                                       :date,
                                       :price, 
                                       :table_id)
  end
  
  def authorize!
    # TODO authorize
  end

  def load_user
    @user = User.find(params["user_id"])
  end

  def date_param
    DateTime.strptime(params[:reservation][:date], '%Y-%m-%d')
  end

  def price_param
    price = params[:reservation][:price].to_i
  end

end

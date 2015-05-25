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
    suggestionEngine = SuggestionEngine.new @user
    @suggestions = suggestionEngine.search date_param, price_param, load_companies_from_param
  end

  def create
    # TODO check again if reservation match the table (in case concurrency problems)
    @reservation = @user.reservations.create(reservation_params)
    render :credit_card_form
  end

  def update
    @reservation.update_customer_information!(params[:stripe_card_token])
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

  # TODO maybe push to suggestion engine
  def load_companies_from_param
    company = []
    params[:reservation][:companies_attributes].each do |company_params|
      c = company_params[1]
      if !c[:age].blank? && !c[:gender].blank?
        company << Company.new(c)
      end
    end
    company
  end

  def date_param
    Date.strptime params[:reservation][:date]
  end

  def price_param
    price = params[:reservation][:price].to_i
  end

end

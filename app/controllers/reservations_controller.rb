class  ReservationsController < UsersController
  before_action :load_user

  def new
    @reservation = @user.reservations.new
  end

  def search
    suggestionEngine = SuggestionEngine.new @user
    @suggestions = suggestionEngine.search date_param, price_param
  end

  private

  def load_user
    @user = User.find(params["user_id"])
  end

  def date_param
    DateTime.strptime(params[:reservation][:date], '%d/%m/%Y')
  end

  def price_param
    price = params[:reservation][:price].to_i
  end

end

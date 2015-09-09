class  Users::ReservationsController < BaseUsersController
  load_resource :id_param => :reservation_id, :through => :user,
                :only => [:reuse_card, :cancel, :menu, :new_evaluation]
  load_resource :only => [:update, :destroy, :show], :through => :user

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
    # TODO check date (from tomorrow + 10 days)
    suggestionEngine = SuggestionEngine.new @user, params[:reservation]
    # TODO limit search on Engine
    @suggestions = suggestionEngine.search.first(3)
    render :no_dinners if @suggestions.empty?
  end

  def last_minute
    if Reservation.off_the_clock?
      render :off_the_clock 
    else
      suggestionEngine = SuggestionEngine.new @user
      @suggestions = suggestionEngine.last_minute.first(3)
      render :no_dinners if @suggestions.empty?
    end
  end

  def create
    # TODO check again if reservation match the table (in case concurrency problems)
    @reservation = @user.reservations.create(reservation_params)
    render :credit_card_form
  end

  def reuse_card
    handle_reservation(@reservation)
  end

  def update
    if @user.update_customer_information!(params[:stripe_card_token])
      handle_reservation(@reservation)
    else
      handle_reservation_error @reservation
    end
  end

  def cancel
    @reservation.cancel
    NotificationManager.notify_user_cancel_reservation(object: @reservation)
    redirect_to user_reservation_path(@user, @reservation), notice: 'Reservation was successfully cancelled.'
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

  def handle_reservation reservation

    if @reservation.closes_last_minute_plan?
      TableManager.process_table reservation.table 
    else
      @user.notify_pending_reservation reservation
    end

    if !reservation.cancelled?
      NotificationManager.notify_user_create_reservation(object: reservation)
      redirect_to user_reservations_path(@user), notice: 'Table reserved succesfully!'
    else
      handle_reservation_error reservation
    end
  end

  def handle_reservation_error reservation
      # TODO handle properly card errors
      reservation.destroy
      redirect_to user_reservations_path(@user), notice: 'There was an error processing your reservation :('
  end

end
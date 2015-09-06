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
    suggestionEngine = SuggestionEngine.new @user, params[:reservation]
    # TODO limit search on Engine
    @suggestions = suggestionEngine.search.first(3)
  end

  def last_minute
    if !@user.has_preferences?
      redirect_to edit_user_path(@user), notice: 'You need to fill your diinner preferences to access the last minute diinners!'
    else
      suggestionEngine = SuggestionEngine.new @user
      @suggestions = suggestionEngine.last_minute
    end
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
       TableManager.process_table @reservation.table if @reservation.closes_last_minute_plan?
      if @reservation.cancelled?
        redirect_to user_reservations_path(@user), notice: 'There was an error processing your reservation :('  
      else
        @reservation.notify "create"
        @user.notify_pending_reservation @reservation
        redirect_to user_reservations_path(@user), notice: 'Table reserved succesfully!'
      end

    else
      # TODO handle properly card errors
      @reservation.delete
      redirect_to user_reservations_path(@user), notice: 'There was an error processing your reservation :('
    end
  end

  def cancel
    @reservation.cancel
    @reservation.notify "cancel"
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

end
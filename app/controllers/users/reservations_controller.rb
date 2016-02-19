class  Users::ReservationsController < BaseUsersController
  load_resource :id_param => :reservation_id, :through => :user,
                :only => [:cancel, :menu, :new_evaluation]
  load_resource :only => [:destroy], :through => :user

  caches_action :show, expires_in: 5.minutes

  def index
    @reservations = @user.reservations.where(cancelled: false).to_a
  end

  def new
    check_preferences
    @reservation = @user.reservations.new
    @reservation.companies.build
    @reservation.companies.build
  end

  def show
    @reservation = Reservation.includes(:table).find(params['id'])
  end

  def search
    suggestionEngine = SuggestionEngine.new @user, params[:reservation]
    # TODO DRY with last minute
    if @user.busy?(suggestionEngine.date)
      redirect_to :back, notice: t("already_have_reservation")
    else
      if suggestionEngine.date_in_range?
        @suggestions = suggestionEngine.search.first(3)
        redirect_to :back, alert: t("no_results") if @suggestions.empty?
      else
        redirect_to :back, notice: t("reservation_lapse")
      end
    end
  end

  def new_last_minute
    # TODO a esto no se llega nunca (creo)
    check_preferences
    @reservation = @user.reservations.new
    @reservation.date = Date.today
  end

  def search_last_minute
    if Reservation.off_the_clock?
      redirect_to :back, alert: t("off_the_clock")
    else
      suggestionEngine = SuggestionEngine.new @user, params[:reservation]
      
      if @user.busy?(suggestionEngine.date)
        redirect_to :back, notice: t("already_have_reservation")
      else
        @suggestions = suggestionEngine.last_minute.first(3)
        redirect_to :back, alert: t("no_results") if @suggestions.empty?
      end
    end
  end

  def create
    # TODO check again if reservation match the table (in case concurrency problems)
    if @user.busy?(Reservation.new(reservation_params).date)
      redirect_to :back, notice: t("already_have_reservation")
    else
      @reservation = @user.reservations.new(reservation_params)
      render :credit_card_form
    end
  end

  def reuse_card
    @reservation = @user.reservations.create(JSON.parse(params[:reservation]))
    handle_reservation(@reservation)
  end


  def new_card
      @reservation = @user.reservations.create(JSON.parse(params[:reservation]))
      if @user.update_customer_information!(params[:stripe_card_token])
        handle_reservation(@reservation)
      else
        # TODO handle card errors
        handle_reservation_error @reservation
      end
  end

  def cancel
    @reservation.cancel

    NotificationManager.notify_user_cancel_reservation(object: @reservation)
    
    EmailNotifications.notify_cancel_reservation @reservation

    redirect_to user_reservations_path(@user), notice: t("cancelation_successful")
  end

  def menu
    @menu = @reservation.menu
  end

  private
  def check_preferences
    if @user.birth.nil? || @user.gender.nil?
      redirect_to user_path(@user),  notice: t("fill_profile")
    end
  end


  def reservation_params
    params.require(:reservation).permit(:user_id,
                                       :date,
                                       :price,
                                       :table_id,
                                       :stripe_card_token,
                                       :after_plan,
                                       companies: [:id, :_gender, :age])
  end

  def handle_reservation reservation

    if @reservation.closes_last_minute_plan?
      TableManager.process_table reservation.table
      if reservation.table.full?
        NotificationManager.notify_full_table(object: reservation.table, to: reservation.restaurant)
        EmailNotifications.notify_table_full reservation.table
      end
    end

    if !reservation.cancelled?
      NotificationManager.notify_user_create_reservation(object: reservation)
      NotificationManager.notify_reservation_pending(object: reservation)

      redirect_to user_reservation_path(@user, reservation), notice: t("reservation_successful")
    else
      handle_reservation_error reservation
    end
  end

  def handle_reservation_error reservation
      reservation.destroy
      redirect_to user_reservations_path(@user), notice: t("reservation_error")
  end

end
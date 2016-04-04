class  Users::ReservationsController < BaseUsersController
  load_resource :id_param => :reservation_id, :through => :user,
                :only => [:cancel, :menu, :new_evaluation]
  load_resource :only => [:destroy], :through => :user


  def index
    # TODO move scope to a better place
    @reservations = @user.reservations.where(cancelled: false).to_a.select{|r| r.table.processed or r.date > Date.today}
  end

  def menu
    @menu = @reservation.menu
  end

  def new
    check_preferences
    @reservation = @user.reservations.new
    @reservation.companies.build
    @reservation.companies.build
  end

  def show
    @reservation = Reservation.includes(:table).find(params['id'])
    redirect_to user_path(@current_user), notice: 'Ha ocurrido un error con la reserva' if !@reservation.table.processed and @reservation.date <= Date.today
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
    if @reservation.use_default_card
      handle_reservation(@reservation)
    else
      handle_reservation_error @reservation
    end
  end


  def new_card
    @reservation = @user.reservations.create(JSON.parse(params[:reservation]))
    if @reservation.update_customer_information!(params[:stripe_card_token])
      if params[:save_card]
        @user.update_customer_information!(@reservation)
      end
      handle_reservation(@reservation)
    else
      handle_reservation_error @reservation
    end
  end

  def cancel
    @reservation.cancel
    NotificationManager.notify_user_cancel_reservation(object: @reservation)
    EmailNotifications.notify_cancel_reservation @reservation

    redirect_to user_reservations_path(@user), notice: t("cancelation_successful")
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

    if reservation.cancelled?
      handle_reservation_error reservation
    else
      NotificationManager.notify_user_create_reservation(object: reservation)
      NotificationManager.notify_reservation_pending(object: reservation)
      redirect_to user_reservation_path(@user, reservation), notice: t("reservation_successful")
    end
  end

  def handle_reservation_error reservation
      reservation.destroy
      redirect_to user_reservations_path(@user), notice: t("reservation_error")
  end

end
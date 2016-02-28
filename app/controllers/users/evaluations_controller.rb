class  Users::EvaluationsController < BaseUsersController
  # load_resource :reservation, :through => :user

  def new
    @evaluation = Evaluation.new
    @reservation = Reservation.find(params[:reservation_id])
    @reservation.evaluation = @evaluation
  end

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @evaluation = @reservation.evaluation.update!(evaluation_params)
    NotificationManager.notify_user_create_evaluation object: @reservation, from: @user
    # Rails.cache.delete("to_evaluate_reservations_" + @user.id.to_s)

    redirect_to users_path(@user), notice: t("evaluation_thanks")
  rescue => e
    render :new
  end

  private
  def evaluation_params
    params.require(:evaluation).permit(:comments,
                                      :had_fun,
                                      :would_recommend,
                                      :quality_of_restaurant,
                                      :quality_of_menu
                                    )
  end
end
class  Users::EvaluationsController < BaseUsersController
  # load_resource :reservation, :through => :user

  def new
    @evaluation = Evaluation.new
    @reservation = Reservation.find(params[:reservation_id])
    @reservation.evaluation = @evaluation
  end

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @reservation.evaluation = Evaluation.create!(evaluation_params)
    @evaluation = @reservation.evaluation
    NotificationManager.notify_user_create_evaluation object: @reservation, from: @user
    redirect_to users_path(@user), notice: t("evaluation_thanks")
  rescue
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
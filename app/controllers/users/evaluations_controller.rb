class  Users::EvaluationsController < BaseUsersController
  load_resource :reservation, :through => :user

  def new
    @evaluation = Evaluation.new
    @reservation.evaluation = @evaluation
  end

  def create
    @evaluation = @reservation.evaluation.update!(evaluation_params)
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
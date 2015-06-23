class  Users::EvaluationsController < BaseUsersController
  load_resource :reservation, :through => :user

  def new
    @evaluation = Evaluation.new
    @reservation.evaluation = @evaluation
  end

  def create
    @evaluation = @reservation.evaluation.update!(evaluation_params)
    @reservation.create_activity key: "evaluation.create", owner: @user, recipient: @reservation.restaurant
    redirect_to users_path(@user), notice: 'Thanks for your evaluation!'
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
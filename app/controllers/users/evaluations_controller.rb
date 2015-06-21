class  Users::EvaluationsController < BaseUsersController
  load_resource :reservation, :through => :user

  def new
    @evaluation = Evaluation.new
    @reservation.evaluation = @evaluation
  end

  def create
    @evaluation = Evaluation.new(evaluation_params)
    @reservation.evaluation = @evaluation
    @evaluation.save!
    redirect_to users_path(@user), notice: 'Thanks for your evaluation!'
  rescue
    render :new
  end

  private
  def evaluation_params
    params.require(:evaluation).permit(:comments)
  end
end
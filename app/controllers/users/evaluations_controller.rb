class  Users::EvaluationsController < BaseUsersController
  load_resource :reservation

 def new
    @evaluation = Evaluation.new
    @reservation.evaluation = @evaluation
  end
end
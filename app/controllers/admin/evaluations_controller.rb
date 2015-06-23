class Admin::EvaluationsController < AdminController

  def index
    @evaluations = Evaluation.desc(:created_at).page(params[:page])
  end

end
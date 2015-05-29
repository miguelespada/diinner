class  Admin::LogsController < AdminController

  def index
    @logs = PublicActivity::Activity.all.desc(:created_at).page(params[:page])
  end

end
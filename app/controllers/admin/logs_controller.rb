class  Admin::LogsController < AdminController

  def index
    @logs = PublicActivity::Activity.all.page(params[:page])
  end

end
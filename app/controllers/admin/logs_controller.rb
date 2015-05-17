class  Admin::LogsController < AdminController

  def index
    @logs = Log.desc(:updated_at).page(params[:page])
  end

end
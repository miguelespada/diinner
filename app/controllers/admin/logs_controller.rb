class  Admin::LogsController < AdminController

  def index
    @logs = Log.desc(:created_at).page params[:page]
  end

end
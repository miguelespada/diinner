class  Admin::LogsController < AdminController

  def index
    @logs = Log.all
  end

end
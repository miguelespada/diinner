class  Admin::LogsController < AdminController

  def index
    @logs = PublicActivity::Activity.all
  end

end
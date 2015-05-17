class AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate_admin!

  def index
    redirect_to admin_logs_path
  end

  def search
    @results = MultiModelSearch.search(params[:query], params[:page])
  end

end

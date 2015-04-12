class AdminController < ActionController::Base

  layout "admin"
  before_filter :authenticate_admin!

  def index
  end

end

class AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate_admin!

  def index
  end

  def search
    @results = MultiModelSearch.search(params[:query], params[:page])
  end

  def show
  end
end

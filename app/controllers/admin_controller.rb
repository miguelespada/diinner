class AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate_admin!

  def index
    redirect_to admin_logs_path
  end

  def search
    @results = MultiModelSearch.search(params[:query], params[:page])
  end

  def logs
    @logs = Admin.logs.page(params[:page])
  end

  def map
    @city = city_param
    @restaurants = Restaurant.where(city: @city)
  end

  def settings
  end

  def process_reservations
    TableManager.process
    # TODO give usefull information
    redirect_to settings_path, notice: 'Reservations processed succesfully!'
  end

  private

  def city_param
    name = params[:city][:city] if params[:city].present?
    City.where(name: name).first || City.first
  end
end

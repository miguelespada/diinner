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
    @logs = PublicActivity::Activity.all.desc(:created_at).page(params[:page])
  end

  def map
    name = params[:city][:city] if params[:city].present?
    @city = City.where(name: name).first || City.first
    @restaurants = Restaurant.where(city: @city)
  end

  def settings
  end

  def process_reservations
    Reservation.process
    # TODO give succesfull information
    redirect_to settings_path, notice: 'Reservations processed succesfully!'
  end
end

class AdminController < ApplicationController
  layout "admin"
  before_filter :sign_out_others
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
    TableManager.process_today_tables
    # TODO give usefull information
    redirect_to settings_path, notice: 'Reservations processed succesfully!'
  end

  def remove_old_tables
    n = TableManager.remove_old_tables
    redirect_to settings_path, notice: "#{n} table(s) removed!"
  end

  def invite_users_to_evaluate
    n = Reservation.invite_to_evaluate
    redirect_to settings_path, notice: "You have invited #{n} user(s) to evaluate their dinners!"
  end

  private

  def city_param
    name = params[:city][:city] if params[:city].present?
    City.where(name: name).first || City.first
  end

  def sign_out_others
    sign_out(current_restaurant) if restaurant_signed_in?
    UserSession.new(session).sign_out
  end
end

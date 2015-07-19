# This controller is for development pourposes

class IonicController < ActionController::Base
  before_action :authenticate

  def update_user
    if @current_user.update(user_params)
      render json: {result: "success"}
    else
      render json: {result: "error"}
    end

  end

  def user
    render json: @current_user.to_ionic_json
  end

  def cities
    render json: {
               cities: City.all.map{ |city| {
                   name: city.name,
                   id: city.id.to_s
                  }
               }
           }
  end

  def notifications
    render json: {
               notifications: @current_user.notifications
           }
  end

  def reservations
    render json: {
               reservations: @current_user.reservations.where(:date.gte => Date.today).map{ |reservation| {
                   reservation: reservation.to_ionic_json
                }
               }
           }
  end

  def cancel_reservation
      @reservation = @current_user.reservations.where(id: params[:reservation_id]).first
      if @reservation.is_owned_by?(@current_user) and @reservation.cancel
        @reservation.notify "cancel"
        render json: {result: "success"}
      else
        render json: {result: "error"}
      end
  end

  def reserve

    reservation = params[:reservation]
    companies = []
    if reservation[:companies]
      reservation[:companies].each{ |company|
        companies.push([ company.id, company.gender, company.age ])
      }
    end
    @reservation = @current_user.reservations.create(user_id: @current_user.id,
                                             date: reservation[:date],
                                             price: reservation[:price],
                                             table_id: reservation[:table_id],
                                             companies: companies)
    @reservation.notify "create"
    render json: {result: "success"}
  end

  def search_tables
    suggestionEngine = SuggestionEngine.new @current_user, JSON.parse(params[:filters]).symbolize_keys!
    # TODO limit search on Engine

    render json: {
               reservations: suggestionEngine.search.first(3).map{ |reservation| {
                   reservation: reservation.to_ionic_json
                  }
               }

           }
  end

  def update_customer
    @current_user.update_customer_information!(params[:payment_token])
    render json: @current_user.to_ionic_json
  end

  private
  def user_params
    params.require(:user).permit(:gender,
                                 :birth,
                                 :preference => [:max_age, :min_age, :menu_price, :id,
                                                 :city_id])
  end

  def authenticate
    @current_user = User.desc(:updated_at).first
  end
end

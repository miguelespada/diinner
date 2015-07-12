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

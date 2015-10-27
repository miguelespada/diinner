# This controller is for development pourposes

class IonicController < ActionController::Base
  attr_reader :current_user
  before_action :authenticate, except: [:cities]

  def user
    render json: @current_user.to_ionic_json
  end

  def update_user
    if @current_user.update(user_params)
      render json: @current_user.to_ionic_json
    else
      render json: {result: "error"}
    end

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
               notifications: @current_user.notifications.map{ |notification|{
                  key: notification.key,
                  owner: {
                       type: notification.owner_type,
                       id: notification.owner_id.to_s,
                       name: notification.owner_type.constantize.find(notification.owner_id).name
                   },
                  creation_date: notification.created_at
                }
               }
           }
  end

  def read_notifications
    render json:  @current_user.to_ionic_json
  end

  def reservations
    render json: {
               reservations: @current_user.reservations.map{ |reservation| {
                   reservation: reservation.to_ionic_json
                }
               }
           }
  end

  def cancel_reservation
      @reservation = @current_user.reservations.where(id: params[:reservation_id]).first
      if @reservation.is_owned_by?(@current_user) and @reservation.cancel
        NotificationManager.notify_user_cancel_reservation(object: @reservation)

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
                                             menu_range: reservation[:menu_range],
                                             table_id: reservation[:table_id],
                                             companies: companies)
    NotificationManager.notify_user_create_reservation(object: @reservation)

    render json: {result: "success"}
  end

  def test
    test = @current_user.test_pending.sample
    render json: {
               test: test ? test.to_ionic_json : {},
                has_test: test != nil
           }
  end

  def save_test
    test = @current_user.test_pending.where(id: params[:test_id]).first
    response = @current_user.test_completed.create!(test: test, response: params[:test_response])
    NotificationManager.notify_user_create_test_response object: response, from: @current_user
    render json: {result: "success"}
  end

  def search_tables

    suggestionEngine = SuggestionEngine.new @current_user, JSON.parse(params[:filters]).symbolize_keys!

    if suggestionEngine.date_in_range?
      render json: {
                 reservations: [],
                 error: 'wrong_date'
             }
    elsif @current_user.busy?(suggestionEngine.date)
      render json: {
                 reservations: [],
                 error: 'reserved_date'
             }
    else
      render json: {
                 reservations: suggestionEngine.search.first(3).map{ |reservation| {
                     reservation: reservation.to_ionic_json
                    }
                 },
                 error: 'none'
             }
    end
  end

  def last_minute

    suggestionEngine = SuggestionEngine.new @current_user, JSON.parse(params[:filters]).symbolize_keys!

    if @current_user.busy?(suggestionEngine.date)
      render json: {
                 reservations: [],
                 error: 'reserved_date'
             }
    else
      render json: {
                 reservations: suggestionEngine.last_minute.first(4).map{ |reservation| {
                     reservation: reservation.to_ionic_json
                   }
                 },
                 error: 'none'

             }
    end
  end

  def update_customer
    @current_user.update_customer_information!(params[:payment_token])
    render json: @current_user.to_ionic_json
  end

  private
  def user_params
    params.require(:user).permit(:gender,
                                 :birth,
                                 :preference => [:max_age, :min_age, :menu_range, :id,
                                                 :city_id])
  end

  def http_auth_token
    @http_auth_token ||= if request.headers['Authorization'].present?
                           request.headers['Authorization'].split(' ').last
                         end
    @http_auth_token
  end

  def authenticate
    user_id = JWT.decode(http_auth_token, nil, false)[0]["sub"]

    auth0 = Auth0Client.new(
        :client_id => ENV["AUTH0_CLIENT_ID"],
        :client_secret => ENV["AUTH0_CLIENT_SECRET"],
        :domain => ENV["AUTH0_DOMAIN"]
    )

    auth0_user = auth0.user(user_id).deep_symbolize_keys!

    profile = {
        userinfo:{
            info:{
                email: auth0_user[:email],
                image: auth0_user[:picture],
                name: auth0_user[:name]
            }
        }
    }

    @session ||= UserSession.new(profile)
    @current_user = @session.user_from_session
  end

  def valid_json?(json)
    begin
      JSON.parse(json)
      return true
    rescue Exception => e
      return false
    end
  end
end

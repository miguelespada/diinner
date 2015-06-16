class BaseRestaurantsController < ApplicationController
  layout "restaurants"
  before_filter :authenticate_restaurant!
  load_resource :restaurant
  before_filter :sign_out_others
  before_filter :authorize!

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if current_restaurant != @restaurant
  end

  def sign_out_others
    sign_out(current_admin) if admin_signed_in?
    UserSession.new(session).sign_out
  end
end
class BaseRestaurantsController < ApplicationController
  layout "restaurants"
  before_filter :authenticate_restaurant!
  load_resource :restaurant
  before_filter :authorize!

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if current_restaurant != @restaurant
  end
end
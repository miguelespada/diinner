class RestaurantsController < ActionController::Base
  layout "restaurants"
  before_filter :authenticate_restaurant!
  load_resource :only => [:show]

  def show
  end
end

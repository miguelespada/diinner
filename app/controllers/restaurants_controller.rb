class RestaurantsController < ActionController::Base
  load_resource :only => [:show]

  def show
  end
end

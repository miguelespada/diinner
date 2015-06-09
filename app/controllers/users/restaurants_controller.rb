class  Users::RestaurantsController < BaseUsersController

  load_resource :restaurant, :only => [:show]

  def show
  end

end
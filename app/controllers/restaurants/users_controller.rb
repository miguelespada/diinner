class Restaurants::UsersController < BaseRestaurantsController
  load_resource :user

  def show
    CanCan::AccessDenied.new("Not authorized!") if !@restaurant.is_customer?(@user)
  end

end
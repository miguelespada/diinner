class  Users::RestaurantsController < UsersController
  load_resource :only => [:show]

  def index
    @restaurants = Restaurant.all
  end

  def show
  end

  def tables
    @tables = Table.all
  end

end

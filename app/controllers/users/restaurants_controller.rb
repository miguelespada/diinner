class  Users::RestaurantsController < UsersController
  load_resource :only => [:show]

  def index
    @restaurants = Restaurant.all
  end

  # TODO USER DO NOT SEE TABLES
  def show
  end

  # TODO ????
  def tables
    @tables = Table.all
  end

end

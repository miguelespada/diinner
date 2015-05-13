class Restaurants::MenusController < RestaurantsController
  load_resource :only => [:show, :edit, :update, :destroy]

  # TODO rebuild tables controller using nested resources, not namespacing

  def index
    @menus = Menu.all
  end

  def new
    @menu = Menu.new
  end

  def show
  end

  def edit
  end

  def create
    # Use helpers @restaurant.menus.create(menu_params)
    @menu = Menu.new(menu_params)
    @menu.restaurant = current_restaurant
    @menu.save!
    redirect_to restaurants_menus_path, :notice => 'Menu was successfully created.'
  end

  def update
    if @menu.update(menu_params)
      redirect_to restaurants_menus_path, notice: 'Menu was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @menu.destroy
    redirect_to restaurants_menus_path, notice: 'Menu was successfully destroyed.'
  end

  private
  def menu_params
    params.require(:menu).permit(:name,
                                 :price,
                                 :appetizer,
                                 :main_dish,
                                 :dessert,
                                 :drink,
                                 :table)
  end

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@menu.is_owned_by?(current_restaurant)
  end
end

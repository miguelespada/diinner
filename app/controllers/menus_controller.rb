class MenusController < RestaurantsController
  before_action :load_restaurant
  load_resource :only => [:show, :edit, :update, :destroy]
  before_filter :authorize!, :only => [:edit, :update, :destroy]
  before_filter :check_menu_empty, :only => [:edit, :update, :destroy]

  def index
    @menus = @restaurant.menus.all
  end

  def new
    @menu = @restaurant.menus.new
  end

  def show
  end

  def edit
  end

  def create
    @menu = @restaurant.menus.create(menu_params)
    @menu.create_activity key: 'menu.create', owner: @restaurant
    redirect_to restaurant_menus_path(@restaurant), :notice => 'Menu was successfully created.'
  end

  def update
    if @menu.update(menu_params)
      redirect_to restaurant_menus_path(@restaurant), notice: 'Menu was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @menu.destroy
    redirect_to restaurant_menus_path(@restaurant), notice: 'Menu was successfully destroyed.'
  end

  private
  def load_restaurant
    @restaurant = Restaurant.find(params["restaurant_id"])
  end

  def menu_params
    params.require(:menu).permit(:name,
                                 :price,
                                 :description,
                                 :appetizer,
                                 :main_dish,
                                 :dessert,
                                 :drink)
  end

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@menu.is_owned_by?(current_restaurant)
  end

  def check_menu_empty
    redirect_to restaurant_menus_path(@restaurant), notice: 'This menu has users.' unless @menu.empty?
  end
end

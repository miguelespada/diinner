class MenusController <  BaseRestaurantsController
  load_resource :except => [:index, :new, :create], :through => :restaurant

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
    # TODO ???
    if @menu.exists_in_database?
      # TODO push notifications to menu
      @menu.create_activity key: 'menu.create', owner: @restaurant
      redirect_to restaurant_menus_path(@restaurant), :notice => 'Menu was successfully created.'
    else
      render :new
    end

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

  def menu_params
    params.require(:menu).permit(:name,
                                 :price,
                                 :description,
                                 :appetizer,
                                 :main_dish,
                                 :dessert,
                                 :drink)
  end

end

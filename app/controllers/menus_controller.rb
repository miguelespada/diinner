class MenusController <  BaseRestaurantsController
  load_resource :except => [:index, :new, :create], :through => :restaurant
  before_filter :redirect_if_non_empty, :only => [:edit, :destroy, :update]

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
    # if @menu.exists_in_database?
      @menu.notify "create"
      redirect_to restaurant_menus_path(@restaurant), :notice => 'Menu was successfully created.'
    # else
    #   render :new
    # end

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

  def redirect_if_non_empty
    if !@menu.empty?
      redirect_to :back, :notice => 'Operation not allowed: menu has users'
    end
  end

end

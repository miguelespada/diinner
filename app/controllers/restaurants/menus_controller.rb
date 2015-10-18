class Restaurants::MenusController <  BaseRestaurantsController
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
    @menu = @restaurant.menus.new(menu_params)
    if @menu.save
      NotificationManager.notify_restaurant_create_menu object: @menu, from: @restaurant
      redirect_to restaurant_menus_path(@restaurant), :notice => 'Menu was successfully created.'
    else
      redirect_to :back, notice: 'Error: menu was not saved.'
    end
  end

  def update
    if @menu.update(menu_params)
      redirect_to restaurant_menus_path(@restaurant), notice: 'Menu was successfully updated.'
    else
      redirect_to :back, notice: 'Error: menu was not saved.'
    end
  end

  def destroy
    if @menu.can_be_deleted?
      @menu.destroy
      redirect_to restaurant_menus_path(@restaurant), notice: 'Menu was successfully destroyed.'
    else
      redirect_to :back, :notice => 'Operation not allowed: there are tables using this menu'
    end
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

  def price_param
    params[:menu][:price].to_i
  end

end

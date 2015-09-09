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
    if allowed_price?
      @menu = @restaurant.menus.create(menu_params)
      NotificationManager.notify_restaurant_create_menu object: @menu, from: @restaurant
      redirect_to restaurant_menus_path(@restaurant), :notice => 'Menu was successfully created.'
    else
      redirect_to restaurant_menus_path(@restaurant)
    end
  end

  def update
    if allowed_price? || @menu.price == price_param
      @menu.update(menu_params)
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

  def price_param
    params[:menu][:price].to_i
  end

  def allowed_price?
    @restaurant.menu_prices_left.include? price_param
  end
end

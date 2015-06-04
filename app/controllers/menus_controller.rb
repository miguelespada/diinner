class MenusController < ApplicationController
  before_filter :authenticate_restaurant!

  load_resource :restaurant
  load_resource :only => [:show, :edit, :update, :destroy]
  before_filter :authorize!, :only => [:show, :edit, :update, :destroy]

  before_filter :check_menu_empty, :only => [:edit, :update, :destroy]
  before_filter :check_max_menus, :only => [:new, :create]

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

  def authorize!
    check_authorization! current_restaurant, @menu
  end



  def check_menu_empty
    # TODO do not put controller logic in actions
    redirect_to restaurant_menus_path(@restaurant), notice: 'This menu has users.' unless @menu.empty?
  end

  def check_max_menus
    # TODO do not put controller logic in actions
    redirect_to restaurant_menus_path(@restaurant), notice: 'You can\'t create more menus.' if @restaurant.menus_full?
  end

end

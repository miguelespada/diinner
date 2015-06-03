class TablesController < RestaurantsController
  before_action :load_restaurant
  load_resource :only => [:show, :edit, :update, :destroy]
  before_filter :check_table_empty, :only => [:edit, :update, :destroy]
  before_filter :check_has_menu, :only => [:new, :create]
  before_action :redirect_if_first_password, only: [:calendar]

  def index
    @tables = @restaurant.tables.all
  end

  def calendar
    @table = @restaurant.tables.find(params[:table_id]) if params[:table_id].present?
    @date_tables = @restaurant.tables.where(:date => Date.strptime(params[:date], "%d/%m/%Y")) if params[:date].present?
    @tables = @restaurant.tables
  end

  def repeat
    # TODO use load_resource?
    @table = @restaurant.tables.find(params[:table_id]) if params[:table_id].present?
    # TODO WTF????
    if request.post? and @table.repeat(repeat_params)
      redirect_to restaurant_tables_path(@restaurant), notice: 'Tables successfully created.'
    else
      render :repeat
    end
  end

  def new
    @table = @restaurant.tables.new
  end

  def show
  end

  def edit
  end

  def create
    @table = @restaurant.tables.create(table_params)
    @table.create_activity key: 'table.create', owner: @restaurant
    redirect_to restaurant_tables_path(@restaurant), :notice => 'Table was successfully created.'
  end

  def update
    if @table.update(table_params)
      redirect_to restaurant_tables_path(@restaurant), notice: 'Table was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @table.destroy
    redirect_to restaurant_tables_path(@restaurant), notice: 'Table was successfully destroyed.'
  end

  private

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def table_params
    params.require(:table).permit(:name, :date, :hour)
  end

  def repeat_params
    params.permit(:days,:times)
  end

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@table.is_owned_by?(current_restaurant)
  end

  def check_table_empty
    redirect_to restaurant_tables_path(@restaurant), notice: 'This table has users.' unless @table.empty?
  end

  def check_has_menu
    redirect_to restaurant_tables_path(@restaurant), :notice => 'You need to create a menu first.' unless @restaurant.has_menus?
  end

  def redirect_if_first_password
    if restaurant_signed_in?
      redirect_to edit_restaurant_password_path(current_restaurant), notice: 'Your must change your password.' if current_restaurant.first_password?
    end
  end
end

class TablesController < RestaurantsController
  before_action :load_restaurant
  load_resource :only => [:show, :edit, :update, :destroy]
  before_filter :check_table_empty, :only => [:edit, :update, :destroy]

  def index
    @tables = @restaurant.tables.all
  end

  def calendar
    @table = @restaurant.tables.find(params[:table_id]) if params[:table_id].present?
    @date_tables = @restaurant.tables.where(:date => Date.strptime(params[:date], "%d/%m/%Y")) if params[:date].present?
    @tables = @restaurant.tables
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

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@table.is_owned_by?(current_restaurant)
  end

  def check_table_empty
    redirect_to restaurant_tables_path(@restaurant), notice: 'This table has users.' unless @table.empty?
  end
end

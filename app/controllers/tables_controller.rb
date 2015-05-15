class  TablesController < RestaurantsController
  before_action :load_restaurant
  load_resource :only => [:show, :edit, :update, :destroy]

  def index
    @tables = @restaurant.tables.all
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
    @restaurant = Restaurant.find(params["restaurant_id"])
  end


  def table_params
    params.require(:table).permit(:name, :date)
  end

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@table.is_owned_by?(current_restaurant)
  end
end

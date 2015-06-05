class TablesController <  BaseRestaurantsController
  load_resource :except => [:index, :new, :create, :calendar], :through => :restaurant

  def index
    @tables = @restaurant.tables
  end

  def calendar
    @table = table_from_param
    @date_tables = date_tables_from_param
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
    params[:table][:number].to_i.times do
      @table = @restaurant.tables.create(table_params)
      @table.notify "create"
    end
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

  def table_params
    params.require(:table).permit(:name, :date, :hour)
  end

  def table_from_param
    @restaurant.tables.find(params[:table_id]) if params[:table_id].present?
  end

  def date_tables_from_param
    @restaurant.tables.where(:date => Date.strptime(params[:date], "%d/%m/%Y")) if params[:date].present?
  end
end

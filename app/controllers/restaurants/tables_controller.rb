class Restaurants::TablesController <  BaseRestaurantsController
  load_resource :except => [:index, :new, :create, :calendar], :through => :restaurant
  before_filter :redirect_if_non_empty, :only => [:edit, :destroy, :update]

  def index
    @tables = @restaurant.tables
  end

  def calendar
    @table = table_from_param
    @date_tables = date_tables_from_param
    @tables = @restaurant.tables
  end

  def new
    redirect_to :back, :notice => 'Operation not allowed: you need to add menus first' if !@restaurant.has_menus?
    @table = @restaurant.tables.new
  end

  def show
  end

  def edit
  end

  def create
    date = table_date
    while date <= repeat_until_date
      table_number.times do
        @table = @restaurant.tables.new(table_params)
        @table.date = date
        @table.save!
        @table.notify "create"
      end
      date = date + 1.week
    end
    redirect_to restaurant_tables_path(@restaurant), :notice => 'Table(s) was successfully created.'
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

  def batch_delete
    tables = @restaurant.tables.any_in(:id => params[:table_ids]).destroy_all
    redirect_to restaurant_tables_path(@restaurant), notice: 'Tables were successfully destroyed.'
  end

  private

  def table_params
    params.require(:table).permit(:date, :hour)
  end

  def table_from_param
    @restaurant.tables.find(params[:table_id]) if params[:table_id].present?
  end

  def date_tables_from_param
    @restaurant.tables.where(:date => Date.strptime(params[:date], "%d/%m/%Y")) if params[:date].present?
  end

  def table_date
     Date.strptime(params[:table][:date], "%d/%m/%Y")
  end

  def table_number
    params[:table][:number].to_i
  end

  def repeat_until_date
    params[:table][:repeat_until].blank? ? table_date : Date.strptime(params[:table][:repeat_until], "%d/%m/%Y")
  end

  def redirect_if_non_empty
    redirect_to :back, :notice => 'Operation not allowed: table has users' if !@table.empty?
  end
end

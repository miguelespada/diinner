class Restaurants::TablesController <  BaseRestaurantsController
  load_resource :only => [:edit, :destroy, :update, :show], :through => :restaurant
  before_filter :redirect_if_non_empty, :only => [:edit, :destroy, :update]

  def index
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
    if table_date.to_date > Date.today
      create_multiple_tables(table_date, repeat_until_date, number_of_repetitions)
      redirect_to restaurant_tables_path(@restaurant), :notice => 'Table(s) was successfully created.'
    else
      redirect_to restaurant_tables_path(@restaurant), :notice => 'You can only create tables starting from tomorrow'
    end
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
    tables = @restaurant.tables.any_in(:id => params[:table_ids])
    n = 0
    tables.each do |table|
      if table.can_be_deleted?
        table.destroy 
        n += 1
      end
    end
    redirect_to restaurant_tables_path(@restaurant), notice: "#{n} table(s) were successfully destroyed."
  end

  private

  def table_params
    params.require(:table).permit(:date, :hour, :menu)
  end

  def table_date
     Date.strptime(params[:table][:date], "%d/%m/%Y")
  end

  def number_of_repetitions
    params[:table][:number].to_i
  end

  def repeat_until_date
    params[:table][:repeat_until].blank? ? table_date : Date.strptime(params[:table][:repeat_until], "%d/%m/%Y")
  end

  def redirect_if_non_empty
    if !@table.can_be_deleted?
      redirect_to :back, :notice => 'Operation not allowed: table has users'
    end 
  end

  def create_multiple_tables from_date, repeat_until, number
    while from_date <= repeat_until
      number.times do
        @table = @restaurant.tables.new(table_params)
        @table.date = from_date
        @table.save!
        NotificationManager.notify_restaurant_create_table object: @table, from: @restaurant
      end
      from_date += 1.week
    end
  end
end

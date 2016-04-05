class Restaurants::TablesController <  BaseRestaurantsController
  include ::TableHelper
  load_resource :only => [:edit, :destroy, :update, :show], :through => :restaurant
  before_filter :redirect_if_non_empty, :only => [:edit, :destroy, :update]

  def index
    @tables = @restaurant.tables.desc(:date).page(params[:page])
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
      n = create_multiple_tables(table_date, repeat_until_date, number_of_repetitions)
      redirect_to restaurant_tables_path(@restaurant), :notice => "#{n} table(s) was successfully created."
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


end

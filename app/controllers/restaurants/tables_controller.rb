class  Restaurants::TablesController < RestaurantsController
  load_resource :only => [:show, :edit, :update, :destroy]

  def index
    @tables = Table.all
  end

  def new
    @table = Table.new
  end

  def show
  end

  def edit
  end

  def create
    @table = Table.new(table_params)
    @table.slots = 6
    @table.status = :empty
    @table.name = @table.id
    @table.restaurant = current_restaurant
    @table.save!
    redirect_to restaurants_tables_path, :notice => 'Table was successfully created.'
  end

  def update
    if @table.update(table_params)
      redirect_to restaurants_table_path, notice: 'Table was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @table.destroy
    redirect_to restaurants_tables_path, notice: 'Table was successfully destroyed.'
  end


  private

  def table_params
    params.require(:table).permit(:date)
  end

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@table.is_owned_by?(current_restaurant)
  end
end

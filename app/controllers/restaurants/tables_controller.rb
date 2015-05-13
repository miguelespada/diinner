class  Restaurants::TablesController < RestaurantsController
  before_action :load_restaurant
  load_resource :only => [:show, :edit, :update, :destroy]


  # TODO rebuild tables controller using nested resources, not namespacing

  def index
  # TODO all???
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
    
    # TODO WTF controller must be THIN!!!!

    @table = Table.new(table_params)
    @table.slots = 6
    @table.status = :empty # TODO this should be model default value
    @table.name = @table.id # TODO What is that?
    @table.restaurant = current_restaurant # TODO nested resources helpers
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

  def load_restaurant
    # TODO this is a temporal patch to solve issue with nested routes
    @restaurant = current_restaurant
  end


  def table_params
    params.require(:table).permit(:date)
  end

  def authorize!
    raise CanCan::AccessDenied.new("Not authorized!") if !@table.is_owned_by?(current_restaurant)
  end
end

class  Users::TablesController < UsersController
  load_resource :only => [:show]

  # TODO USER DO NOT SEE TABLES AS LIST
  def index
    @tables = Restaurant.find(params[:restaurant_id]).tables
  end

  def show
  end

  def reserve
    @table = Table.find(params[:table_id])
    @table.users << @current_user
    redirect_to user_path(@current_user), :notice => 'Table was successfully reserved.'
  end
end

class Restaurants::CalendarsController <  BaseRestaurantsController

  def show
    @table = table_from_param
    @date_tables = date_tables_from_param
    @tables = @restaurant.tables
  end

  private

  def table_from_param
    @restaurant.tables.find(params[:table_id]) if params[:table_id].present?
  end

  def date_tables_from_param
    @restaurant.tables.where(:date => Date.strptime(params[:date], "%d/%m/%Y")) if params[:date].present?
  end

end

module TableHelper
  def table_params
    params.require(:table).permit(Table.permitted_params)
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
    if admin_signed_in?
      @restaurant = Restaurant.find(params[:table][:restaurant_id])
    end
    n = 0
    while from_date <= repeat_until
      number.times do
        @table = @restaurant.tables.new(table_params)
        #TODO delete and move to create form. Dynamic menu selector depending on restaurant.
        @table.menu = @restaurant.menus.first if @table.menu.nil?

        @table.date = from_date
        @table.save!
        n += 1
        NotificationManager.notify_restaurant_create_table object: @table, from: @restaurant
      end
      from_date += 1.week
    end
    n
  end
end
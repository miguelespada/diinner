class Admin::TablesController < AdminController
  include ::TableHelper
  load_resource :only => [:show, :edit, :update, :process_payment]

  def index 
    @tables = Table.desc(:date).page(params[:page])
  end

  def new
    @table = Table.new
  end

  def show
  end

  def edit

  end

  def create
    if table_date.to_date > Date.today
      n = create_multiple_tables(table_date, repeat_until_date, number_of_repetitions)
      redirect_to admin_tables_path, :notice => "#{n} table(s) was successfully created."
    else
      redirect_to admin_tables_path, :notice => 'You can only create tables starting from tomorrow'
    end
  end

  def update
    if @table.update(table_params)
      redirect_to admin_tables_path, notice: 'Table was successfully updated.'
    else
      render :edit
    end
  end

  def process_payment
    TableManager.process_table @table
    redirect_to admin_tables_path
  end

  private

  def table_params
    params.require(:table).permit(Table.permitted_params)
  end
end
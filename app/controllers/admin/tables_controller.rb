class Admin::TablesController < AdminController
  load_resource :only => [:show, :process_payment]

  def index
    @tables = Table.desc(:created_at).page(params[:page])
  end

  def show
  end

  def process_payment
    TableManager.process_table @table
    redirect_to admin_tables_path
  end
end
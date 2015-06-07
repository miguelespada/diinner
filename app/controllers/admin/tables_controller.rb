class Admin::TablesController < AdminController
  load_resource :only => [:show]

  def index
    @tables = Table.desc(:created_at).page(params[:page])
  end

  def show
  end

end
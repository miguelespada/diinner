class  Admin::TablesController < AdminController
  load_resource :only => [:show]

  def index
    @tables = Table.all
  end

  def show
  end
end
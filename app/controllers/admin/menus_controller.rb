class Admin::MenusController < AdminController
  load_resource :only => [:show]

  def index
    @menus = Menu.desc(:created_at).page(params[:page])
  end

  def show
  end

end
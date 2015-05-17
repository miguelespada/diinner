class Admin::MenusController < AdminController
  load_resource :only => [:show]

  def index
    @menus = Menu.all
  end

  def show
  end

end
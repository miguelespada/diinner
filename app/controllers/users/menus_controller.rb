class  Users::MenusController < BaseUsersController

  load_resource :menu, :only => [:show]

  def show
  end

end
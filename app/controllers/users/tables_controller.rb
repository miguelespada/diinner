class  Users::TablesController < BaseUsersController

  load_resource :table, :only => [:show]

  def show
  end

end
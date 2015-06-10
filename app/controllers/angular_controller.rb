class AngularController < ApplicationController

  def index
    @users = User.all
  end
end

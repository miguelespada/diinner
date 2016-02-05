class StaticController < ApplicationController
  layout "static"
  def index
   render layout: "home"
  end

  def help
  end

  def protected
  end


end
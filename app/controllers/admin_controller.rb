class AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate_admin!

  def index
  end


  # TODO: do not add code if there is not test
  # TODO Thin controllers!
  # TODO User DSL
  # TODO User multimodel search
  
  def search
    query = params[:query]
    query_es = {query: { prefix: { name: query } }}

    @restaurants = Restaurant.search(query_es).results
    # @users = User.search(query_es).results

  end

  def show

  end
end

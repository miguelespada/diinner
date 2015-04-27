require "pry"
class AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate_admin!

  def index
  end

  def search
    @results = Elasticsearch::Model.search(params[:query], [Restaurant, User]).results
  end

  def show
  end
end

require "pry"
class AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate_admin!

  def index
  end

  def search
    # TODO create a service
    
    query = Jbuilder.encode do |json|
          json.query do
            json.match do
              json._all do
                json.query params[:query]
                json.fuzziness 5
                json.prefix_length 3
              end
            end
          end
        end

    @results = Elasticsearch::Model.search(query, [Restaurant, User]).results
  end

  def show
  end
end

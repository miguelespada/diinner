class StaticController < ApplicationController
  layout "static"

  before_action :redirect_if_authenticated, only: [:index]
  caches_action :index
  
  def index
    @blog_posts = BlogPost.get_three_random
    render layout: "home"
  end

  def expire
    expire_action :action => 'index'
    render nothing: true
  end

  def cocktail
  end

  def help_user
  end

  def help_restaurant
  end

  def protected
  end

  def drop_out
  end

  private

  def redirect_if_authenticated
    @session ||= UserSession.new(session)
    if @session.logged?
      @current_user = @session.user_from_session
      redirect_to user_path(@current_user)
    end
  end


end
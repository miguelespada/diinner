class StaticController < ApplicationController
  layout "static"
  def index
    @blog_posts = BlogPost.get_three_random
   render layout: "home"
  end

  def help_user
  end

  def help_restaurant
  end

  def protected
  end


end
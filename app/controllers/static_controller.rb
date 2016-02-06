class StaticController < ApplicationController
  layout "static"
  def index
    @blog_posts = BlogPost.get_three_random
   render layout: "home"
  end

  def help
  end

  def protected
  end


end
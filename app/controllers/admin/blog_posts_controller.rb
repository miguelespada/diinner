class  Admin::BlogPostsController < AdminController
  load_resource :only => [:show, :edit, :update, :destroy]

  def index
    @blog_posts = BlogPost.all
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    @blog_post.save!
    redirect_to admin_blog_posts_path, :notice => 'BlogPost was successfully created.'
  end

  def destroy
    @blog_post.destroy
    redirect_to admin_blog_posts_path, notice: 'BlogPost was successfully destroyed.'
  end

  def edit
  end

  def update
    @blog_post.update(blog_post_params)
    redirect_to admin_blog_posts_path, notice: 'BlogPost was successfully updated.'
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title,
                                  :picture,
                                  :url)
  end

end
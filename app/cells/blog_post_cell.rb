class BlogPostCell < BaseCell
  include CloudinaryHelper

  def delete_link
    if admin_signed_in?
     @path = admin_blog_post_path(model)
     render
    end
  end

  def edit_link
    if admin_signed_in?
      @path = edit_admin_blog_post_path(model)
      render
    end
  end

  def show_link
    if admin_signed_in?
      @path = admin_blog_post_path(model)
      render
    end
  end

  def show_icon
    if admin_signed_in?
      @path = admin_blog_post_path(model)
      render
    end
  end


  def new_link
    if admin_signed_in?
      @path = new_admin_blog_post_path
      render
    end
  end

  # def blog_post_responses
  #   if admin_signed_in?
  #     table "Blog_post Responses", \
  #       %w(Question User Response), \
  #       cell(:blog_post, collection: model.responses, method: :response)
  #   end
  # end

  private

  # TODO do a yml file
  # BAD SMELL too many literals

  def phone_mockup
    image_tag "http://res.cloudinary.com/hotvlwxi4/image/upload/v1430319550/iPhone_nddjjt.png", class: "phone-mockup"
  end

  def phone_toolbar
    image_tag "http://res.cloudinary.com/hotvlwxi4/image/upload/v1430319549/phone_toolbar_xx29ck.png", class: "phone-toolbar"
  end

  def phone_like_button
    image_tag "http://res.cloudinary.com/hotvlwxi4/image/upload/v1430319550/like_button_hykzmo.png", class: "phone-like-button"
  end

  private

  # BAD SMELL duplicate condition
  def cl_image image, width, height
    cl_image_tag(image.path, { size: "#{width}x#{height}", crop: :fill, radius: 2 }) if image.present?
  end
end
class TestCell < BaseCell
  include CloudinaryHelper
  
  def delete_link
   @path = admin_test_path(model)
   render
  end

  def edit_link
    @path = edit_admin_test_path(model)
    render
  end
  
  def show_link
    @path = admin_test_path(model)
    render "show_icon"
  end

  def new_link
    @path = new_admin_test_path
    render
  end

  def responses
    if admin_signed_in?
      render
    end
  end


  # TODO do a yml file
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

  def cl_image image, width, height
    cl_image_tag(image.path, { size: "#{width}x#{height}", crop: :fill, radius: 2 }) if image.present?
  end
end
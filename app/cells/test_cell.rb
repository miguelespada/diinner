class TestCell < BaseCell
  include CloudinaryHelper
  include Sprockets::Rails::Helper
  self.assets_prefix = Rails.application.config.assets.prefix
  self.assets_environment = Rails.application.assets
  
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
    render
  end

  def new_link
    @path = new_admin_test_path
    render
  end

  def phone_mockup
    image_tag "iPhone.png", class: "phone-mockup"
  end

  def phone_toolbar
    image_tag "phone_toolbar.png", class: "phone-toolbar"
  end

  def phone_like_button
    image_tag "like_button.png", class: "phone-like-button"
  end

  private

  def cl_image image, width, height
    cl_image_tag(image.path, { size: "#{width}x#{height}", crop: :fill, radius: 2 }) if image.present?
  end
end
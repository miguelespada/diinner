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
    render
  end

  private
  property :question
  property :caption_A
  property :caption_B

  def cl_image image, size
    cl_image_tag(image.path, { size: "#{size}x#{size}", crop: :fit }) if image.present?
  end
end
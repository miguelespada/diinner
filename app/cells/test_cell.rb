class TestCell < BaseCell
  include CloudinaryHelper

  private
  property :question
  property :caption_A
  property :caption_B

  def cl_image image, size
    cl_image_tag(image.path, { size: "#{size}x#{size}", crop: :fit }) if image.present?
  end
end
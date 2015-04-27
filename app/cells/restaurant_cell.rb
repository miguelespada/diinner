class RestaurantCell < BaseCell
  include ActionView::Helpers::DateHelper
  def delete_link
    @path = admin_restaurant_path(model)
    render
  end

  def new_link
    @path = new_admin_restaurant_path
    render
  end

  private
  
  def status
    "Last time active: " + (@model.current_sign_in_at.nil? ? "never" : time_ago_in_words( @model.current_sign_in_at )).to_s
  end
end
class RestaurantCell < BaseCell
  include ActionView::Helpers::DateHelper
  def delete_link
    @path = admin_restaurant_path(model)
    render
  end

  private
  
  def status
    last_activity = @model.current_sign_in_at.nil? ? "never" : time_ago_in_words( @model.current_sign_in_at )
    "Last time active: " + last_activity
  end

  # TODO ??? 
  # TODO View accessing the Model!!! WTF!

  def from_elasticsearch
    Restaurant.find(model.id)
  end
end

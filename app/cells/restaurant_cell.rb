class RestaurantCell < BaseCell
  include ActionView::Helpers::DateHelper
  
  private
  def status
    last_activity = @model.current_sign_in_at.nil? ? "never" : time_ago_in_words( @model.current_sign_in_at )
    "Last time active: " + last_activity
  end

  # TODO ??? 
  # TODO View accessing the model!!! WTF!

  def from_elasticsearch
    Restaurant.find(model.id)
  end
end

class RestaurantCell < BaseCell
  private
  def status
    last_activity = model.current_sign_in_at.nil? ? "never" : model.current_sign_in_at.to_s 
    "Last time active: " + last_activity
  end
end


class RestaurantCell < BaseCell
  include ActionView::Helpers::DateHelper
  def row
    render
  end

  def dropdown_menu
    render
  end

  def profile
    render
  end
  private
  def status
    "Inactive"
  end

  def logout_link
    render
    last_activity = model.current_sign_in_at.nil? ? "never" : time_ago_in_words( model.current_sign_in_at )
    "Last time active: " + last_activity
  end

  def profile_link
    render
  end
end
